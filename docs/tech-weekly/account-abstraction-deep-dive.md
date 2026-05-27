# ERC-4337 Account Abstraction & Paymaster — Technical Deep Dive

## 1. Architecture Overview

```
                         ERC-4337 Architecture
 ============================================================================

  User (no ETH)                        Bundler (EOA with ETH)
       |                                      |
       | 1. Create UserOperation               |
       | 2. Sign with account key              |
       |-------------------------------------->|
       |        (off-chain, via RPC)           |
       |                                      |
       |                          3. Bundle multiple UserOps
       |                          4. Call handleOps() as regular tx
       |                                      |
       |                                      v
       |                        +---------------------------+
       |                        |     EntryPoint Contract    |
       |                        |   (Singleton, Deployed at  |
       |                        |    same addr all chains)   |
       |                        +---------------------------+
       |                        |                           |
       |               5. Validation Phase          6. Execution Phase
       |                        |                           |
       |                 +------+------+             +------+------+
       |                 |             |             |             |
       |                 v             v             v             v
       |          +-----------+  +-----------+  +-----------+  +-----------+
       |          |  Account  |  | Paymaster |  |  Account  |  | Paymaster |
       |          | validate  |  | validate  |  |  execute  |  |  postOp   |
       |          | UserOp()  |  | UserOp()  |  | (callData)|  |           |
       |          +-----------+  +-----------+  +-----------+  +-----------+

 ============================================================================
  Key Insight: EntryPoint는 유일하게 msg.value/gas를 다루는 컨트랙트.
  Smart account과 paymaster는 raw ETH gas 메커니즘을 직접 다루지 않음.
 ============================================================================
```

## 2. Core Data Structures

### PackedUserOperation (v0.7+)

```solidity
struct PackedUserOperation {
    address sender;              // Smart account 주소
    uint256 nonce;               // uint192(key) || uint64(sequence) — 2D nonce
    bytes initCode;              // Factory 주소 + 생성 calldata (최초 배포 시)
    bytes callData;              // 실제 실행할 호출 데이터
    bytes32 accountGasLimits;    // packed: uint128(verificationGasLimit) || uint128(callGasLimit)
    uint256 preVerificationGas;  // calldata 비용 + bundler 오버헤드
    bytes32 gasFees;             // packed: uint128(maxPriorityFeePerGas) || uint128(maxFeePerGas)
    bytes paymasterAndData;      // paymaster(20) || pmVerificationGasLimit(16)
                                 //   || pmPostOpGasLimit(16) || paymasterData(...)
    bytes signature;             // Account 전용 서명
}
```

v0.7에서 11개 필드 → 9개로 축소. gas 파라미터를 bytes32에 패킹하여 L2 calldata 비용 절감.

### Gas Budget 구성

```
 Total gas = verificationGasLimit
           + callGasLimit
           + paymasterVerificationGasLimit
           + paymasterPostOpGasLimit
           + preVerificationGas

 requiredPrefund = totalGas * maxFeePerGas
```

| 항목 | 용도 |
|------|------|
| preVerificationGas | intrinsic gas (21000) + calldata + L1 posting cost (L2) |
| verificationGasLimit | account.validateUserOp() + 계정 배포 |
| callGasLimit | account.execute(callData) |
| pmVerificationGasLimit | paymaster.validatePaymasterUserOp() |
| pmPostOpGasLimit | paymaster.postOp() |

## 3. Key Contract Interfaces

### IAccount

```solidity
interface IAccount {
    function validateUserOp(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash,                // EIP-712 hash
        uint256 missingAccountFunds        // EntryPoint에 예치해야 할 ETH
    ) external returns (uint256 validationData);
    // validationData 패킹:
    //   <20-byte> aggregatorOrSigFail  (0 = valid, 1 = sig failure, other = aggregator)
    //   <6-byte>  validUntil           (0 = 무제한)
    //   <6-byte>  validAfter
}
```

### IPaymaster

```solidity
interface IPaymaster {
    enum PostOpMode {
        opSucceeded,       // UserOp 성공
        opReverted,        // UserOp revert됨, paymaster는 여전히 gas 지불
        postOpReverted     // 내부 전용, paymaster에 전달되지 않음
    }

    function validatePaymasterUserOp(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash,
        uint256 maxCost                    // gas * maxFeePerGas (최대 ETH 비용)
    ) external returns (
        bytes memory context,              // postOp()에 전달됨; empty = postOp 스킵
        uint256 validationData
    );

    function postOp(
        PostOpMode mode,
        bytes calldata context,
        uint256 actualGasCost,             // 실제 gas 비용 (wei)
        uint256 actualUserOpFeePerGas
    ) external;
}
```

### IEntryPoint (핵심 함수)

```solidity
interface IEntryPoint is IStakeManager, INonceManager {
    function handleOps(
        PackedUserOperation[] calldata ops,
        address payable beneficiary         // Bundler 주소, 수수료 수령
    ) external;

    function getUserOpHash(
        PackedUserOperation calldata userOp
    ) external view returns (bytes32);
}
```

## 4. UserOperation 생명주기 — 전체 흐름

### Phase 1: 구성 (Off-chain)

```
1. UserOperation 구성
   - sender: Smart account 주소 (아직 미배포일 수 있음)
   - nonce: EntryPoint.getNonce(sender, key)에서 조회
   - initCode: 계정 미배포 시 factory 주소 + creation calldata
   - callData: ABI 인코딩된 호출 (예: token.transfer())
   - gas 파라미터: eth_estimateUserOperationGas로 추정
   - paymasterAndData: paymaster 주소 + paymaster 전용 데이터

2. Paymaster 사용 시, Paymaster 서명 요청 (ERC-7677 API)
   → Paymaster가 정책 검증 (허용 컨트랙트? rate limit?)
   → 서명된 paymasterAndData 반환

3. 사용자가 UserOp 서명
   hash = EntryPoint.getUserOpHash(userOp)
   signature = sign(hash, accountKey)

4. Bundler에 제출: eth_sendUserOperation(userOp, entryPointAddress)
```

### Phase 2: Bundler 검증 (Off-chain)

```
5. 로컬 시뮬레이션: EntryPoint.simulateValidation(userOp)
   - 스토리지 접근 규칙 (ERC-7562) 검증
   - 금지된 opcode 확인
   - paymaster deposit이 maxCost를 커버하는지 확인

6. Mempool에 추가 → 여러 UserOp을 하나의 트랜잭션으로 번들링
```

### Phase 3: On-chain 검증

```solidity
// EntryPoint.handleOps() 내부
function handleOps(PackedUserOperation[] calldata ops, address payable beneficiary) {
    UserOpInfo[] memory opInfos = new UserOpInfo[](ops.length);

    // PHASE 1: 모든 UserOp 검증 (하나라도 실패하면 전체 revert)
    _iterateValidationPhase(ops, opInfos, address(0), 0);

    // PHASE 2: 모든 UserOp 실행
    uint256 collected = 0;
    emit BeforeExecution();
    for (uint256 i = 0; i < ops.length; i++) {
        collected += _executeUserOp(i, ops[i], opInfos[i]);
    }

    // PHASE 3: Bundler에게 수수료 지급
    _compensate(beneficiary, collected);
}
```

**핵심 보안 속성: Two-Phase 분리**
- 검증과 실행이 엄격히 분리됨
- 모든 검증이 통과해야 실행 시작
- 악의적 UserOp이 다른 UserOp을 무효화하는 것을 방지

### Phase 4: On-chain 실행

```
각 UserOp에 대해:
a. innerHandleOp 호출 (새 call frame → revert 격리)
b. 63/64 규칙으로 충분한 gas 확인
c. account.sender에 callData 실행
d. actualGas 계산 (미사용 gas 페널티 10% 포함)
e. paymaster context가 있으면 postOp() 호출
f. 환불 = prefund - actualGasCost → paymaster(또는 account)에 반환
g. UserOperationEvent 발행
```

## 5. Paymaster 패턴 3가지

### Pattern A: Verifying Paymaster (Gas 스폰서)

프로젝트/dApp이 사용자 gas를 대납. 백엔드 signer가 각 UserOp을 승인.

```solidity
contract VerifyingPaymaster is BasePaymaster {
    address public verifyingSigner;

    function _validatePaymasterUserOp(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash,
        uint256 maxCost
    ) internal override returns (bytes memory context, uint256 validationData) {
        (uint48 validUntil, uint48 validAfter, bytes calldata signature)
            = _parsePaymasterData(userOp.paymasterAndData);

        bytes32 hash = MessageHashUtils.toEthSignedMessageHash(
            getHash(userOp, validUntil, validAfter)
        );

        // 백엔드 signer가 이 UserOp을 승인했는지 검증
        if (verifyingSigner != ECDSA.recover(hash, signature)) {
            return ("", _packValidationData(true, validUntil, validAfter));
        }

        return ("", _packValidationData(false, validUntil, validAfter));
        // context가 비어있으므로 postOp 호출되지 않음
    }
}
```

**흐름:** 사용자 → Paymaster API에 UserOp 제출 → 정책 검증 → 서명 반환 → on-chain 검증

### Pattern B: ERC-20 Token Paymaster

사용자가 USDC, KSD 등의 토큰으로 gas를 지불.

```solidity
contract ERC20Paymaster is BasePaymaster {
    IERC20 public immutable token;
    IOracle public immutable tokenOracle;
    uint256 public constant PRICE_MARKUP = 110;  // 10% 마진

    function _validatePaymasterUserOp(...) internal override
        returns (bytes memory context, uint256 validationData)
    {
        uint256 tokenPrice = _getTokenPrice();
        uint256 tokenAmount = (maxCost * PRICE_MARKUP / 100) / tokenPrice;

        // 검증 단계에서는 allowance만 확인 (스토리지 접근 제한)
        require(token.allowance(userOp.sender, address(this)) >= tokenAmount);

        // 실제 토큰 전송은 postOp에서 수행
        context = abi.encode(userOp.sender, tokenAmount, tokenPrice, maxCost);
        return (context, 0);
    }

    function _postOp(...) internal override {
        // 실제 gas 사용량 기반으로 토큰 전송
        uint256 actualTokenCost = (actualGasCost * PRICE_MARKUP / 100) / tokenPrice;
        token.transferFrom(sender, address(this), actualTokenCost);
    }
}
```

**주요 포인트:** 토큰 전송은 `validatePaymasterUserOp`이 아닌 `postOp`에서 실행. 검증 단계에서는 스토리지 접근 제한이 있기 때문.

**리스크:** UserOp 실행 중 토큰 잔액이 줄어들면 postOp에서 transfer 실패 → paymaster가 gas 비용을 부담. 마진(PRICE_MARKUP)으로 오라클 가격 변동 리스크 커버.

### Pattern C: 하이브리드 (스폰서 + 토큰 폴백)

특정 작업은 스폰서, 나머지는 토큰 결제. 백엔드 정책으로 결정.

## 6. Paymaster 경제학

```
 Paymaster Economic Flow
 ============================================================================

  Paymaster Operator (EOA)
       |
       | 1. depositTo(paymaster) — ETH를 EntryPoint에 예치
       v
  EntryPoint deposits[paymaster] = ETH
       |
       | 2. UserOp당: deposit -= requiredPrefund
       | 3. 실행 후: 미사용 gas 환불
       |
       | UserOp당 순비용 = actualGas * effectiveGasPrice
       |
  ERC-20 Paymaster의 경우:
  - ETH deposit ↓ (gas 지불)
  - ERC-20 잔액 ↑ (사용자로부터 수령)
  - 운영자가 주기적으로 토큰 → ETH 스왑 후 재예치
 ============================================================================
```

### Staking (Reputation)

```solidity
function addStake(uint32 unstakeDelaySec) external payable;
function unlockStake() external;
function withdrawStake(address payable withdrawAddress) external;
```

- **Stake**: 평판 담보로 잠긴 ETH (deposit과 별도)
- **Deposit**: gas 비용 지불에 사용되는 운영 ETH
- Bundler가 최소 unstakeDelay 강제 (예: 1일)
- 검증 실패가 빈번한 paymaster는 throttle/ban

## 7. Base / Coinbase Paymaster 통합

### Coinbase Developer Platform (CDP) Paymaster

```
  dApp Frontend
       |
       | 1. UserOp 생성
       | 2. 스폰서 요청
       v
  Coinbase Paymaster API (ERC-7677)
  https://api.developer.coinbase.com/rpc/v1/base/{API_KEY}
       |
       | 3. 서명된 paymasterAndData 반환
       v
  Coinbase Bundler → Base EntryPoint v0.7
```

### permissionless.js 통합 코드

```typescript
import { createSmartAccountClient } from "permissionless";
import { toSimpleSmartAccount } from "permissionless/accounts";
import { createPimlicoClient } from "permissionless/clients/pimlico";

// Smart Account 생성
const account = await toSimpleSmartAccount({
  client: publicClient,
  owner: privateKeyToAccount("0x..."),
  entryPoint: { address: ENTRYPOINT_V07, version: "0.7" },
});

// Paymaster 클라이언트 (Coinbase 호스팅)
const paymasterClient = createPimlicoClient({
  transport: http("https://api.developer.coinbase.com/rpc/v1/base-sepolia/{API_KEY}"),
  entryPoint: { address: ENTRYPOINT_V07, version: "0.7" },
});

// Smart Account Client = Account + Bundler + Paymaster
const smartAccountClient = createSmartAccountClient({
  account,
  chain: baseSepolia,
  bundlerTransport: http("https://api.developer.coinbase.com/rpc/v1/base-sepolia/{API_KEY}"),
  paymaster: paymasterClient,
});

// 가스 없이 트랜잭션 전송!
const txHash = await smartAccountClient.sendTransaction({
  to: KSD_CONTRACT,
  data: encodeFunctionData({
    abi: ksdAbi,
    functionName: "mint",
    args: [userAddress, amount],
  }),
});
```

## 8. 실전 적용: Gasless KSD Workshop

### 현재 vs 개선

```
 현재 (ETH 필요):
  1. EOA 지갑 생성
  2. Faucet에서 테스트 ETH 수령   ← 마찰 포인트
  3. KSD.mint() 호출 (ETH로 gas 지불)

 개선 (Account Abstraction):
  1. Smart Account 생성 (counterfactual, 배포 tx 불필요)
  2. Paymaster가 gas 대납              ← Faucet 불필요
  3. KSD.mint() 호출 (gas 무료)
  4. (선택) KSD 토큰으로 gas 지불
```

### 구현 옵션 (복잡도 순)

| 옵션 | 방법 | 복잡도 | 장점 |
|------|------|--------|------|
| A | Coinbase CDP Paymaster | 낮음 | 컨트랙트 배포 불필요, 무료 테스트넷 |
| B | 자체 Verifying Paymaster | 중간 | 완전한 정책 제어 |
| C | KSD Token Paymaster | 높음 | 사용자가 KSD로 gas 지불 |

### 비용 추정 (Base)

```
Base Sepolia: 무료 (테스트넷)
Base Mainnet: ~$0.001/UserOp
              $1로 ~1000 operations 스폰서 가능
```

## 9. 주의사항

| 항목 | 내용 |
|------|------|
| L2 Gas 추정 | preVerificationGas에 L1 data posting 비용 포함. bundler의 eth_estimateUserOperationGas 사용 필수 |
| 미사용 Gas 페널티 | v0.7에서 미사용 gas 40k 초과분의 10% 페널티. 과추정하면 paymaster 비용 증가 |
| postOp Revert | postOp revert 시 전체 innerHandleOp revert 후 postOpReverted 모드로 재실행. 토큰 전송 실패 = paymaster가 gas 비용 부담 |
| Nonce | 2D nonce: uint192(key) \|\| uint64(sequence). 다른 key로 병렬 UserOp 가능 |
| EntryPoint 주소 | v0.7: `0x0000000071727De22E5E9d8BAf0edAc6f37da032` (모든 EVM 체인 동일) |
| 최초 배포 Gas | 첫 UserOp은 계정 배포로 +200-400k gas. 이후 100-200k |

## 10. postOp Double-Call Pattern

- If postOp reverts, EntryPoint catches and calls postOp AGAIN with mode=postOpReverted
- This second call MUST NOT revert
- Prevents users from getting free gas by making postOp revert intentionally
- Critical for ERC-20 Paymaster security

## 11. Key Presentation Takeaways

1. ERC-4337 requires no protocol changes — entirely smart contract level
2. Two-loop design (validate-then-execute) prevents cross-UserOp invalidation
3. Paymasters break the chicken-and-egg onboarding problem
4. Gas model is self-balancing via deposit/refund/compensate
5. v0.7 packs gas fields for L2 efficiency
6. For KSD workshop: Coinbase Paymaster on Base Sepolia eliminates ETH requirement with ~50 lines of TypeScript

## 12. 참고 자료

- [ERC-4337 Spec](https://eips.ethereum.org/EIPS/eip-4337)
- [eth-infinitism/account-abstraction](https://github.com/eth-infinitism/account-abstraction) — 레퍼런스 구현
- [Coinbase Paymaster Examples](https://github.com/coinbase/paymaster-bundler-examples)
- [permissionless.js](https://docs.pimlico.io/permissionless) — Smart Account SDK
- [ERC-7677](https://eips.ethereum.org/EIPS/eip-7677) — Paymaster Web Service 표준
