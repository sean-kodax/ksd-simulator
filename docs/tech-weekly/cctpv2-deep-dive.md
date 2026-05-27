# CCTPv2 Attestation Protocol — Technical Deep Dive

소스: [circlefin/evm-cctp-contracts](https://github.com/circlefin/evm-cctp-contracts)

## 1. 컨트랙트 아키텍처

```
 CCTPv2 Contract Architecture
 ============================================================================

  Source Chain (Ethereum)              Destination Chain (Base)
  ========================             ========================

  사용자                                Relayer (누구나 가능)
    |                                      |
    | 1. depositForBurn()                   | 5. receiveMessage(message, attestation)
    v                                      v
  +------------------+              +------------------+
  | TokenMessengerV2 |              | TokenMessengerV2 |
  | - burn USDC      |              | - mint USDC      |
  | - format message |              | - deduct fee     |
  +------------------+              | - execute hook   |
    |                               +------------------+
    | 2. sendMessage()                     ^
    v                                      | 4. handleReceive*Message()
  +---------------------+           +---------------------+
  | MessageTransmitterV2|           | MessageTransmitterV2|
  | - emit MessageSent  |           | - verify attestation|
  | - assign nonce      |           | - check nonce       |
  +---------------------+           +---------------------+
         |                                ^
         | 3. Off-chain                    |
         v                                |
  +------------------+                    |
  | Circle IRIS API  |--------------------+
  | (Attestation     |  attestation (65-byte ECDSA signatures)
  |  Service)        |
  +------------------+

 ============================================================================
  TokenMinterV2: 각 체인에서 로컬 USDC의 mint/burn 권한 관리
  Attestable: 다중 attester의 ECDSA 서명 검증 (m-of-n multisig)
 ============================================================================
```

## 2. Message Format

### Outer Message (MessageV2)

```
 Field                        Bytes      Type       Index
 version                      4          uint32     0
 sourceDomain                 4          uint32     4
 destinationDomain            4          uint32     8
 nonce                        32         bytes32    12
 sender                       32         bytes32    44
 recipient                    32         bytes32    76
 destinationCaller            32         bytes32    108
 minFinalityThreshold         4          uint32     140
 finalityThresholdExecuted    4          uint32     144
 messageBody                  dynamic    bytes      148
```

### Inner Message Body (BurnMessageV2)

```
 Field                 Bytes      Type       Index
 version               4          uint32     0
 burnToken             32         bytes32    4
 mintRecipient         32         bytes32    36
 amount                32         uint256    68
 messageSender         32         bytes32    100
 maxFee                32         uint256    132      ← V2 신규
 feeExecuted           32         uint256    164      ← V2 신규
 expirationBlock       32         uint256    196      ← V2 신규
 hookData              dynamic    bytes      228      ← V2 신규
```

**V1 대비 V2 추가 필드:**
- `maxFee` — 목적지 체인에서 지불할 최대 수수료 (Fast Transfer 인센티브)
- `feeExecuted` — 실제 차감된 수수료
- `expirationBlock` — 메시지 만료 블록
- `hookData` — 목적지 체인에서 mint 후 실행할 커스텀 로직

## 3. 핵심 흐름 — 코드 레벨

### Step 1: depositForBurn (Source Chain)

```solidity
// TokenMessengerV2.sol:166
function depositForBurn(
    uint256 amount,
    uint32 destinationDomain,
    bytes32 mintRecipient,
    address burnToken,
    bytes32 destinationCaller,
    uint256 maxFee,                    // V2: Fast Transfer 수수료 상한
    uint32 minFinalityThreshold       // V2: 최소 finality 수준
) external notDenylistedCallers { ... }

// With Hook (V2 전용)
function depositForBurnWithHook(
    uint256 amount,
    uint32 destinationDomain,
    bytes32 mintRecipient,
    address burnToken,
    bytes32 destinationCaller,
    uint256 maxFee,
    uint32 minFinalityThreshold,
    bytes calldata hookData            // V2: 목적지에서 실행할 데이터
) external notDenylistedCallers { ... }
```

내부 구현:

```solidity
// TokenMessengerV2.sol:332
function _depositForBurn(...) internal {
    require(_amount > 0, "Amount must be nonzero");
    require(_mintRecipient != bytes32(0), "Mint recipient must be nonzero");
    require(_maxFee < _amount, "Max fee must be less than amount");

    // 최소 수수료 검증
    if (minFee > 0) {
        require(_maxFee >= _calcMinFeeAmount(_amount), "Insufficient max fee");
    }

    // 1. USDC를 burn
    _depositAndBurn(_burnToken, msg.sender, _amount);

    // 2. BurnMessage 포맷팅
    bytes memory _burnMessage = BurnMessageV2._formatMessageForRelay(
        messageBodyVersion,
        _burnToken.toBytes32(),
        _mintRecipient,
        _amount,
        msg.sender.toBytes32(),
        _maxFee,
        _hookData
    );

    // 3. MessageTransmitter를 통해 메시지 발송
    IRelayerV2(localMessageTransmitter).sendMessage(
        _destinationDomain,
        _destinationTokenMessenger,
        _destinationCaller,
        _minFinalityThreshold,
        _burnMessage
    );

    emit DepositForBurn(...);
}
```

### Step 2: sendMessage (MessageTransmitterV2)

```solidity
// MessageTransmitterV2.sol:143
function sendMessage(
    uint32 destinationDomain,
    bytes32 recipient,
    bytes32 destinationCaller,
    uint32 minFinalityThreshold,
    bytes calldata messageBody
) external override whenNotPaused {
    require(destinationDomain != localDomain, "Domain is local domain");
    require(messageBody.length <= maxMessageBodySize);
    require(recipient != bytes32(0));

    // 메시지 직렬화
    bytes memory _message = MessageV2._formatMessageForRelay(
        version,
        localDomain,
        destinationDomain,
        msg.sender.toBytes32(),    // sender = TokenMessengerV2
        recipient,                  // recipient = 목적지 TokenMessengerV2
        destinationCaller,
        minFinalityThreshold,
        messageBody
    );

    // 이벤트만 발행 — Circle의 off-chain 서비스가 이 이벤트를 감지
    emit MessageSent(_message);
}
```

**핵심:** `sendMessage`는 상태를 변경하지 않고 **이벤트만 발행**합니다. nonce 할당도 메시지 포맷에 포함되지만, 실제 사용 여부는 목적지 체인에서 관리합니다.

### Step 3: Attestation (Off-chain — Circle IRIS API)

```
 1. Circle의 attester 노드가 MessageSent 이벤트를 감지
 2. 소스 체인에서 트랜잭션 finality 확인
    - minFinalityThreshold 기준 (V2 신규)
    - threshold 500 = ~30초, 1000 = ~1분, 2000(finalized) = ~15분
 3. 메시지 해시에 ECDSA 서명
    digest = keccak256(message)
    signature = ECDSA.sign(digest, attesterPrivateKey)
 4. m-of-n multisig: signatureThreshold 수만큼의 서명 수집
 5. attestation = concat(sig1, sig2, ..., sigM) — 각 65 bytes
    (주의: attester 주소의 오름차순으로 정렬 필수)
 6. IRIS API를 통해 attestation 제공
    GET https://iris-api.circle.com/v2/attestations/{messageHash}
```

### Step 4: receiveMessage (Destination Chain)

```solidity
// MessageTransmitterV2.sol:206
function receiveMessage(
    bytes calldata message,
    bytes calldata attestation
) external override whenNotPaused returns (bool success) {

    // 1. 메시지 + 서명 검증
    (bytes32 _nonce, uint32 _sourceDomain, bytes32 _sender,
     address _recipient, uint32 _finalityThresholdExecuted,
     bytes memory _messageBody
    ) = _validateReceivedMessage(message, attestation);

    // 2. Nonce 사용 처리 (재사용 방지)
    usedNonces[_nonce] = NONCE_USED;

    // 3. Finality 수준에 따라 다른 핸들러 호출 (V2 신규)
    if (_finalityThresholdExecuted < FINALITY_THRESHOLD_FINALIZED) {
        // Fast Transfer: 아직 완전 finalize 안 됨 → 수수료 차감
        IMessageHandlerV2(_recipient).handleReceiveUnfinalizedMessage(
            _sourceDomain, _sender, _finalityThresholdExecuted, _messageBody
        );
    } else {
        // Standard Transfer: 완전 finalize됨 → 수수료 없음
        IMessageHandlerV2(_recipient).handleReceiveFinalizedMessage(
            _sourceDomain, _sender, _finalityThresholdExecuted, _messageBody
        );
    }

    emit MessageReceived(...);
    return true;
}
```

## 4. Attestation 서명 검증 — 핵심 보안

```solidity
// Attestable.sol:227
function _verifyAttestationSignatures(
    bytes calldata _message,
    bytes calldata _attestation
) internal view {
    // 1. attestation 길이 = 65 * signatureThreshold
    require(
        _attestation.length == signatureLength * signatureThreshold,
        "Invalid attestation length"
    );

    address _latestAttesterAddress = address(0);

    // 2. 메시지 해시 계산
    bytes32 _digest = keccak256(_message);

    // 3. 각 서명 검증
    for (uint256 i; i < signatureThreshold; ++i) {
        bytes memory _signature = _attestation[
            i * signatureLength : i * signatureLength + signatureLength
        ];

        // ECDSA.recover로 서명자 주소 복구
        address _recoveredAttester = ECDSA.recover(_digest, _signature);

        // 서명자 주소는 반드시 오름차순 (중복 방지)
        require(
            _recoveredAttester > _latestAttesterAddress,
            "Invalid signature order or dupe"
        );

        // 등록된 attester인지 확인
        require(
            isEnabledAttester(_recoveredAttester),
            "Invalid signature: not attester"
        );

        _latestAttesterAddress = _recoveredAttester;
    }
}
```

**보안 속성:**
- `keccak256(message)` → ECDSA 서명 → 등록된 attester만 유효한 서명 생성 가능
- 오름차순 정렬 강제 → 같은 attester의 중복 서명 방지
- m-of-n multisig → signatureThreshold 수 이상의 attester가 동의해야 메시지 유효

## 5. V1 vs V2 핵심 차이

### Finality Thresholds (V2 신규)

```solidity
// FinalityThresholds.sol
uint32 constant FINALITY_THRESHOLD_FINALIZED = 2000;   // 완전 finality (~15분)
uint32 constant FINALITY_THRESHOLD_CONFIRMED = 1000;   // confirmed (~1분)
uint32 constant TOKEN_MESSENGER_MIN_FINALITY_THRESHOLD = 500; // 최소 허용 (~30초)
```

V1은 무조건 full finality를 기다렸지만, V2는 사용자가 `minFinalityThreshold`를 선택:
- **500 (Fast)**: ~30초, 수수료 발생 (Relayer 리스크 보상)
- **1000 (Confirmed)**: ~1분
- **2000 (Finalized)**: ~15분, 수수료 없음 (V1과 동일)

### Fast Transfer 수수료 구조

```solidity
// TokenMessengerV2.sol — handleReceiveUnfinalizedMessage
// 아직 finalize 안 된 메시지 → 수수료 차감 후 mint
function handleReceiveUnfinalizedMessage(
    uint32 remoteDomain,
    bytes32 sender,
    uint32 finalityThresholdExecuted,    // 실제 실행된 finality 수준
    bytes calldata messageBody
) external override returns (bool) {
    require(
        finalityThresholdExecuted >= TOKEN_MESSENGER_MIN_FINALITY_THRESHOLD,
        "Unsupported finality threshold"
    );
    return _handleReceiveMessage(messageBody.ref(0), remoteDomain);
}
```

**수수료 흐름:**
- 사용자가 `maxFee`를 설정하여 burn
- Relayer가 finalized 이전에 메시지를 릴레이하면, `feeExecuted` 만큼 차감
- 수수료는 `feeRecipient` 주소에 별도 mint
- 수수료 = Relayer가 부담하는 reorg 리스크에 대한 보상

### Hooks (V2 신규)

```solidity
// depositForBurnWithHook — hookData를 BurnMessage에 포함
function depositForBurnWithHook(
    uint256 amount,
    uint32 destinationDomain,
    bytes32 mintRecipient,
    address burnToken,
    bytes32 destinationCaller,
    uint256 maxFee,
    uint32 minFinalityThreshold,
    bytes calldata hookData             // ← 목적지에서 실행할 데이터
) external notDenylistedCallers {
    require(hookData.length > 0, "Hook data is empty");
    _depositForBurn(..., hookData);
}
```

**Hook 활용 예시:**
- USDC 전송 후 자동으로 DEX 스왑 실행
- 전송과 동시에 DeFi 프로토콜에 예치
- NFT 구매 + USDC 결제를 하나의 크로스체인 트랜잭션으로

```solidity
// CCTPHookWrapper.sol (예시)
// mintRecipient을 이 컨트랙트로 설정하면, mint 후 hookData를 해석하여 추가 로직 실행
```

### Denylist (V2 신규)

```solidity
modifier notDenylistedCallers() {
    require(!isDenylisted(msg.sender), "Caller is denylisted");
    _;
}
```

V2에서는 특정 주소의 `depositForBurn` 호출을 차단할 수 있음 (제재 준수).

## 6. V1 vs V2 비교 요약

| 기능 | V1 | V2 |
|------|-----|-----|
| Finality | Full finality만 | 3단계 (500/1000/2000) 선택 |
| 속도 | ~15분 | ~30초 (Fast Transfer) |
| 수수료 | 없음 | Fast Transfer 시 maxFee 기반 |
| Hooks | 없음 | hookData로 post-mint 로직 실행 |
| Denylist | 없음 | 발신자 차단 기능 |
| 메시지 핸들러 | handleReceiveMessage | handleReceiveFinalizedMessage + handleReceiveUnfinalizedMessage |
| BurnMessage | 5 필드 (100 bytes) | 8 필드 (228+ bytes) |
| 컨트랙트 | MessageTransmitter, TokenMessenger | MessageTransmitterV2, TokenMessengerV2, TokenMinterV2 |

## 7. 보안 고려사항

### Attestation 신뢰 모델

- Circle이 운영하는 attester 노드의 **m-of-n multisig**
- 현재 n = 소수의 Circle 운영 attester (중앙화 요소)
- `signatureThreshold` 조정으로 보안 수준 변경 가능
- Attester 추가/제거는 `attesterManager`만 가능

### Nonce Replay 방지

```solidity
usedNonces[_nonce] = NONCE_USED;  // 한 번 사용된 nonce는 재사용 불가
```

### destinationCaller 제한

```solidity
if (_msg._getDestinationCaller() != bytes32(0)) {
    require(
        _msg._getDestinationCaller() == msg.sender.toBytes32(),
        "Invalid caller for message"
    );
}
```

`bytes32(0)`이면 누구나 relay 가능. 특정 주소로 지정하면 해당 주소만 `receiveMessage` 호출 가능.

### Fast Transfer 리스크

- `minFinalityThreshold = 500` → 소스 체인에서 아직 reorg 가능
- Reorg 발생 시: 소스 체인의 burn이 취소되었지만, 목적지에서는 이미 mint됨
- Circle이 이 리스크를 부담 → `maxFee`로 보상

## 8. 참고 자료

- [CCTPv2 Whitepaper](https://6778953.fs1.hubspotusercontent-na1.net/hubfs/6778953/PDFs/Whitepapers/CCTPV2_White_Paper.pdf)
- [circlefin/evm-cctp-contracts](https://github.com/circlefin/evm-cctp-contracts) — 전체 소스코드
- [Circle CCTP Developer Docs](https://developers.circle.com/cctp)
- [IRIS API Documentation](https://developers.circle.com/cctp/reference/getattestation)
