# KSD Stablecoin Workshop

스테이블코인(USDC) 교육을 위한 실습 시뮬레이터. 금융인 대상, 비개발자도 체험 가능.

## 수강생 접속 URL

| 용도 | URL |
|------|-----|
| **예습/복습 (Step 1~7)** | https://sean-kodax.github.io/ksd-simulator/ksd-simulator.html |
| **워크숍 당일 (Step 1~8)** | `./start-workshop.sh` 실행 후 출력되는 ngrok URL |

> Step 8 (x402 결제)은 API 서버가 필요하므로 GitHub Pages에서는 작동하지 않습니다.

## 워크숍 8단계

| Step | 내용 | 태그 |
|------|------|------|
| 1 | 지갑 연결 + 에어드랍 + 네트워크 설정 | 실행 |
| 2 | KSD 발행 (Mint) | 분석 → 실행 |
| 3 | 준비금 대시보드 + Circle 보고서 | 분석 → 실행 |
| 4 | KSD 소각 (Burn) + 환매 | 분석 → 실행 |
| 5 | 페깅/차익거래 시뮬레이션 + SVB 사례 | 분석 → 실행 |
| 6 | 실제 USDC Mint 트랜잭션 추적 | 분석 |
| 7 | CCTPv2 크로스체인 전송 체험 | 분석 → 실행 |
| 8 | x402 결제로 수료 뱃지 구매 (KSD) | 분석 → 실행 |

## 워크숍 당일 실행

### 1. 실습 환경 시작

```bash
./start-workshop.sh
```

스크립트가 자동으로:
- 통합 서버 시작 (시뮬레이터 + x402 API, 포트 4021)
- ngrok 터널 연결
- 수강생 접속 URL 출력
- CCTPv2 데모 앱 시작 여부 확인 (선택)

### 2. 에어드랍 실행

수강생이 구글 폼에 지갑 주소를 제출하면, BaseScan에서 일괄 에어드랍:

1. [BaseScan Write Contract](https://sepolia.basescan.org/address/0xbd4a74fdedf23004f8ff0998e48678b40e6bbc04#writeContract) 접속
2. "Connect to Web3" → MetaMask 연결
3. `airdrop` 함수에 수강생 주소 배열 입력
4. 실행 → 전원에게 0.002 ETH + 100 KSD 동시 전송

### 3. CCTPv2 체험 (Step 7)

CCTPv2 데모 앱은 `start-workshop.sh`에서 선택적으로 시작됩니다.
별도 ngrok이 필요하므로 **강사 화면 공유로 시연**하거나, 수강생은 `http://localhost:3002`로 접근합니다.

테스트넷 USDC는 [Circle Faucet](https://faucet.circle.com/)에서 수령 (계정 불필요).

## 사전 준비 체크리스트

### 강사

- [ ] Airdrop 컨트랙트에 ETH 충전 (수강생 수 x 0.002 ETH)
  ```bash
  source .env
  cast send 0xbd4a74fdedf23004f8ff0998e48678b40e6bbc04 \
    --value 0.1ether \
    --rpc-url https://base-sepolia-rpc.publicnode.com \
    --private-key $PRIVATE_KEY
  ```
- [ ] `./start-workshop.sh` 실행 테스트
- [ ] ngrok URL 접속 확인
- [ ] 구글 폼 링크 준비 (주소 수집용)
- [ ] CCTPv2용 Ethereum Sepolia USDC 확보 ([Circle Faucet](https://faucet.circle.com/))

### 수강생

- [ ] MetaMask 브라우저 확장프로그램 설치
- [ ] MetaMask에서 Base Sepolia RPC URL 설정: `https://base-sepolia-rpc.publicnode.com`

## 배포 정보

| 항목 | 값 |
|------|-----|
| KSD 컨트랙트 | `0xbAa67736C4c403e35384783100e00e2DFF454f6c` |
| Airdrop 컨트랙트 | `0xbd4a74fdedf23004f8ff0998e48678b40e6bbc04` |
| 체인 | Base Sepolia (Chain ID: 84532) |
| BaseScan | https://sepolia.basescan.org/address/0xbAa67736C4c403e35384783100e00e2DFF454f6c |
| GitHub Pages | https://sean-kodax.github.io/ksd-simulator/ksd-simulator.html |
| GitHub Repo | https://github.com/sean-kodax/ksd-simulator |

## 프로젝트 구조

```
StableCoin/
├── app/
│   └── ksd-simulator.html      # 수강생용 시뮬레이터 (단일 HTML)
├── src/
│   ├── KSD.sol                  # KSD 토큰 컨트랙트
│   └── KSDAirdrop.sol           # 에어드랍 컨트랙트
├── test/
│   ├── KSD.t.sol                # KSD 테스트 (14개)
│   └── KSDAirdrop.t.sol         # Airdrop 테스트 (6개)
├── script/
│   ├── Deploy.s.sol             # KSD 배포 스크립트
│   └── DeployAirdrop.s.sol      # Airdrop 배포 스크립트
├── x402-server/
│   ├── server.js                # 통합 서버 (시뮬레이터 + x402 API)
│   └── package.json
├── start-workshop.sh            # 워크숍 환경 원클릭 실행
├── .env                         # 프라이빗 키 (git 제외)
└── README.md
```

## 기술 스택

- **스마트 컨트랙트:** Solidity 0.8.28, OpenZeppelin ERC20, Foundry
- **프론트엔드:** 단일 HTML, ethers.js v6 (CDN)
- **x402 서버:** Node.js, Express
- **배포:** Base Sepolia, GitHub Pages, ngrok
