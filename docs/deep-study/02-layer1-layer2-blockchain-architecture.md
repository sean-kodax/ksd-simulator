# Layer 1 / Layer 2 블록체인 아키텍처

## Layer 1이란?

**기술적 정의:** 자체 합의 메커니즘(Consensus)을 가진 독립적인 기반 블록체인. 자체적으로 트랜잭션을 검증하고 최종성(Finality)을 보장한다.

쉬운 비유: **"도로 자체"** — 차가 달리는 기반 인프라.

**핵심 책임:**
- 합의 (이 트랜잭션이 유효한가?)
- 보안 (누가 위변조를 시도하면 막는다)
- 분산 (누구도 단독으로 통제할 수 없다)

### 주요 Layer 1 블록체인

| 체인 | 합의 메커니즘 | TPS (실제) | 가스비 | 특징 |
|------|-------------|-----------|--------|------|
| **Bitcoin** | PoW (Proof of Work) | ~7 | $1~5 | 최초, 가장 안전, 가장 느림 |
| **Ethereum** | PoS (Proof of Stake) | ~30 | $0.5~10 | 스마트 컨트랙트 원조, DeFi/NFT 생태계 |
| **Solana** | PoH + PoS | ~957 (최대 6,284) | $0.00025 | 가장 빠름, 고성능 트레이딩 |
| **BNB Chain** | PoSA (Proof of Staked Authority) | ~183 | $0.05~0.2 | Binance 생태계, 아시아 중심 |
| **Avalanche** | Snow Consensus | ~4,500 | $0.01~0.1 | 서브넷 구조, 빠른 최종성 |
| **Cardano** | Ouroboros PoS | ~250 | $0.1~0.3 | 학술적 접근, 아프리카 포커스 |

### Layer 1의 근본적 딜레마 — 블록체인 트릴레마

```
        보안성 (Security)
           △
          / \
         /   \
        /     \
       /       \
      /    ??    \
     /           \
    ◁─────────────▷
탈중앙성              확장성
(Decentralization)    (Scalability)

세 가지를 동시에 만족시킬 수 없다.
Bitcoin: 보안+탈중앙 → 확장성 희생 (7 TPS)
Solana: 보안+확장성 → 탈중앙성 희생 (검증자 하드웨어 요구 높음)
```

이 트릴레마를 해결하기 위해 **Layer 2**가 등장한다.

---

## Layer 2란?

**기술적 정의:** Layer 1 위에 구축된 보조 프로토콜. 트랜잭션을 L1 밖에서(off-chain) 처리하고, 결과만 L1에 기록하여 속도와 비용을 개선한다. **보안은 L1에 의존.**

쉬운 비유: **"고속도로 위의 고가도로"** — 기존 도로의 용량 한계를 우회하지만, 최종적으로는 원래 도로에 연결된다.

### 작동 원리

```
기존 (L1만):
  사용자 → [트랜잭션] → L1에서 검증+기록 → 완료
  속도: 느림, 비용: 높음

L2 사용 시:
  사용자 → [트랜잭션] → L2에서 처리 → 결과 요약을 L1에 기록 → 완료
  속도: 빠름, 비용: 낮음, 보안: L1과 동일
```

### L2의 주요 유형

| 유형 | 작동 방식 | 대표 | 특징 |
|------|----------|------|------|
| **Optimistic Rollup** | 트랜잭션이 유효하다고 "낙관적으로" 가정, 이의 제기 시 검증 | Optimism, Arbitrum, **Base** | 이더리움 호환, 현재 주류 |
| **ZK Rollup** | 영지식 증명으로 트랜잭션 유효성을 수학적으로 증명 | zkSync, StarkNet, Scroll | 더 안전하지만 복잡 |
| **Payment Channel** | 두 사용자 간 오프체인 채널을 열어 다수 거래 후 결산 | Lightning Network | 비트코인 결제 특화 |
| **Sidechain** | 별도 합의를 가진 체인이 L1에 연결 | Polygon PoS, Rootstock | 자체 보안 (L1 보안 아님) |
| **Validium** | ZK 증명 사용하지만 데이터는 오프체인 보관 | Immutable X | 게임/NFT 특화 |

### 주요 Ethereum Layer 2

| L2 | 유형 | TPS | 가스비 | 특징 |
|----|------|-----|--------|------|
| **Base** | Optimistic Rollup | ~2,000+ | $0.001~0.01 | Coinbase 운영, USDC 핵심 체인, **KSD 실습 체인** |
| **Arbitrum** | Optimistic Rollup | ~4,000 | $0.01~0.1 | DeFi TVL 1위 L2 |
| **Optimism** | Optimistic Rollup | ~2,000 | $0.01~0.05 | OP Stack (Base도 이걸로 만들어짐) |
| **zkSync Era** | ZK Rollup | ~2,000 | $0.01~0.05 | 네이티브 Account Abstraction |
| **StarkNet** | ZK Rollup (STARK) | ~1,000 | $0.01~0.05 | Cairo 언어, 독자적 생태계 |

---

## 비트코인 위에 올라간 레이어들

비트코인은 스마트 컨트랙트가 제한적이라, L2의 접근 방식이 이더리움과 다르다.

### 1. Lightning Network — 결제 채널

```
Alice와 Bob이 채널을 열고 (L1 트랜잭션 1회)
→ 채널 안에서 1,000번 거래 (오프체인, 수수료 거의 0)
→ 채널을 닫음 (L1 트랜잭션 1회)
→ L1에는 2건만 기록, 실제로는 1,000건 처리
```

- 노드 17,000+, 채널 40,000+, 용량 ~4,900 BTC
- 엘살바도르 법정화폐 결제, 아프리카/남미 송금에 활용
- **결제 특화** — 스마트 컨트랙트는 안 됨

### 2. Stacks — 비트코인의 스마트 컨트랙트 레이어

- 비트코인에 스마트 컨트랙트 기능을 추가
- **sBTC**: 비트코인과 1:1 페깅된 토큰으로 DeFi 활용
- Nakamoto 업그레이드 후 거의 즉시 최종성 달성
- Clarity 언어 사용 (Solidity와 다름)

### 3. Rootstock (RSK) — 비트코인의 EVM 호환 사이드체인

- **Merged Mining**: 비트코인 채굴자가 동시에 RSK도 검증 → 비트코인 보안 활용
- EVM 호환 → Solidity로 개발 가능, 이더리움 DApp 이식 용이
- 비트코인 해시파워의 ~60%가 참여

### 4. Liquid Network — 기관 정산용 사이드체인

- Blockstream이 운영하는 **연합형(Federated) 사이드체인**
- 기관 간 빠른 비트코인 정산, 토큰 발행에 특화
- Confidential Transactions (거래 금액 비공개)
- 탈중앙화 수준 낮음 (연합 멤버가 검증)

### 5. RGB Protocol — 클라이언트 측 검증 (가장 주목)

- **2025.8: Tether가 RGB를 통해 비트코인 위에 USDT 네이티브 발행 발표**
- 기존 Omni Layer(2014년 최초 USDT 발행 체인)의 후계자
- 핵심 차이: 스마트 컨트랙트 로직을 **온체인이 아닌 클라이언트 측에서 실행**

```
이더리움 방식: 모든 노드가 컨트랙트를 실행 → 느리고 비쌈
RGB 방식:     사용자 클라이언트만 검증 → 빠르고 저렴, 프라이버시 보장
              비트코인은 "커밋먼트(증거)"만 기록
```

이것이 의미하는 것: **USDT가 비트코인에 "귀환"한다** — 2014년 Omni에서 시작해서 Ethereum/Tron으로 이주했던 USDT가, 12년 만에 더 발전된 형태(RGB)로 비트코인에 돌아온다.

### 6. Omni Layer — 역사적 레이어 (쇠퇴)

- 2014년 최초의 USDT가 발행된 프로토콜
- J.R. Willett의 Mastercoin이 진화한 것
- Tether가 Omni 지원을 중단 → 사실상 역사 속으로
- **역사적 의미**: 스테이블코인의 탄생지

### 비트코인 레이어 생태계 요약

```
                     Bitcoin (Layer 1)
                          │
          ┌───────────────┼───────────────┐
          │               │               │
    결제 채널         스마트 컨트랙트      토큰/자산
          │               │               │
   Lightning         Stacks (L2)      RGB Protocol
   Network           Rootstock (사이드)   (클라이언트 측)
                     Liquid (연합형)    Omni (레거시)
                          │
                          │
              ┌───────────┼───────────┐
              │           │           │
           sBTC        DeFi     USDT on RGB
          (BTC 페깅)              (2025 발표)
```

---

## 강의에서의 활용 포인트

> "우리 KSD 실습은 **Base** 위에서 합니다. Base는 Ethereum의 Layer 2입니다. 이더리움의 보안을 그대로 사용하면서, 가스비는 $0.001 수준입니다. CCTPv2로 Ethereum ↔ Base 간 USDC를 전송하는 것도, L1과 L2 사이의 이동입니다."

> "그리고 흥미로운 점 — 2014년 비트코인 위 Omni Layer에서 시작된 USDT가, 12년 만에 RGB Protocol을 통해 비트코인으로 돌아오고 있습니다. J.R. Willett이 꿈꿨던 '비트코인 위의 프로토콜 레이어'가 마침내 성숙한 형태로 실현되는 것입니다."

---

## 참고 자료

- [Gemini — Layer 1 and Layer 2 Networks](https://www.gemini.com/cryptopedia/blockchain-layer-2-network-layer-1-network)
- [Bitcoin.com — Bitcoin Layer-2 Solutions](https://www.bitcoin.com/get-started/bitcoin-layer-2-solutions/)
- [CryptoMinerBros — Top 10 Bitcoin Layer 2 Solutions 2026](https://www.cryptominerbros.com/blog/top-10-bitcoins-layer-2-solutions/)
- [Spark — Bitcoin Layer 2 Comparison](https://www.spark.money/research/bitcoin-layer-2-comparison)
- [The Block — Tether USDT on RGB Protocol](https://www.theblock.co/post/368613/tether-to-bring-native-stablecoin-rail-to-bitcoin-with-usdt-rollout-on-rgb)
- [RGB Protocol 공식](https://rgb.tech/)
