# BitUSD 디페깅 사건 (2018.11)

> **정정:** BitUSD 디페깅은 2014년이 아닌 **2018년 11월**. 2014.7은 BitUSD **출시일**이고, 디페깅은 4년 뒤에 발생.

## BitUSD는 어떻게 작동했는가

```
일반적 이해:    "1 BitUSD = $1 보장"
실제 메커니즘:  BTS(BitShares 토큰)를 200% 담보로 예치 → BitUSD 발행

예시:
  사용자가 $200 어치 BTS를 예치
  → 100 BitUSD 발행 (200% 담보비율)
  → BTS 가격이 떨어지면 → 담보비율 하락 → 마진콜
```

**핵심 설계:** BitUSD를 발행하는 사람은 사실상 **"BTS의 달러 가격을 숏(short)하는 것"**이다. $200 어치 BTS를 맡기고 $100 BitUSD를 빌리는 구조. BTS가 오르면 이익, 떨어지면 손실.

**치명적 결함:**
- 담보가 **BTS라는 변동성 자산** 하나에만 의존
- BTS 가격 하락 시 담보 가치가 빠르게 무너짐
- 가격 안정 메커니즘이 **BTS 가격 하락에만 대응** — BitUSD 자체 가격 하락에는 보호 장치 없음

---

## 무엇이 일어났는가

### 배경: 2018년 암호화폐 대폭락

```
BTS 가격 추이:
  2018.1:  ~$0.90 (최고점 부근)
  2018.6:  ~$0.20
  2018.11: ~$0.04 (최고점 대비 -95%)
```

2018년은 암호화폐 전체가 폭락한 해다. BTS도 예외가 아니었고, 최고점 대비 **95% 하락**했다.

### 타임라인

**2018년 초~중반 — 서서히 무너지는 담보**
- BTS 가격이 지속적으로 하락
- BitUSD 담보비율이 200% → 150% → 100%로 계속 떨어짐
- 마진콜 발생 → 담보 BTS가 강제 매각 → BTS 가격 추가 하락 → 악순환

**2018.9~10 — 디페깅 시작**
- BitUSD가 $1에서 이탈하기 시작 → $0.90, $0.85...
- 유동성 부족: BitUSD를 $1에 사줄 사람(매수자)이 시장에 없음
- BitUSD는 시장 가격으로만 교환 가능해짐 — 즉 $1 보장이 사라짐

**2018.11.25 — Global Settlement (글로벌 결산) 발동**

**Global Settlement**이란 BitShares의 비상 절차다:
- **가장 낮은 담보비율의 포지션이 현재 가격으로 전체 부채를 갚을 수 없을 때** 발동
- 모든 BitUSD 차입(숏 포지션)이 강제 청산됨
- BitUSD 발행이 완전히 중단됨
- BitUSD 보유자는 **시장 가격의 BTS로만 환매** 가능

```
Global Settlement 발동 시점:
  BitUSD 보유자가 환매하면: 1 BitUSD → ~$0.70 어치 BTS
  = 30% 손실 확정
```

**2018.11 이후 — 회복 불가**
- BitUSD 발행 중단 → 새로운 공급 없음
- 환매는 $0.70~0.80 수준에서만 가능
- $1 페깅 영구 상실
- BitUSD는 사실상 "죽은 토큰"이 됨

---

## 왜 디페깅되었는가 — 3가지 구조적 원인

### 1. 단일 변동성 자산 담보

```
BitUSD: BTS(변동성 95%)가 유일한 담보
DAI (2019 이후): ETH + BAT + USDC + 여러 자산으로 분산
```

BTS 하나가 떨어지면 전체 시스템이 무너지는 구조.

### 2. 비대칭적 보호 메커니즘

- BTS 가격 하락 → 마진콜 → 담보 강제 매각 (보호 작동)
- **BitUSD 가격 하락 → 보호 장치 없음** (치명적)
- BitUSD가 $0.90이 되어도 시스템이 이를 $1로 복원할 메커니즘이 없었음

### 3. 유동성 부족

- BitShares DEX의 거래량이 매우 적었음
- BitUSD를 $1에 매수할 차익거래자가 충분하지 않았음
- 유동성이 없으면 페깅 메커니즘(차익거래)이 작동하지 않음

---

## Dan Larimer의 역할과 이후

- Dan Larimer는 BitUSD/BitShares를 만든 후, 이미 **2017년에 EOS 프로젝트로 이동**
- BitShares 커뮤니티가 자체 관리했으나, 핵심 설계 결함을 해결하지 못함
- Global Settlement 이후 BSIP(BitShares Improvement Proposal)으로 개선 시도했으나, 이미 시장의 신뢰를 잃은 후

---

## 결과와 교훈

| 항목 | BitUSD | 이후 교훈이 반영된 사례 |
|------|--------|---------------------|
| 담보 | BTS 단일 자산 | DAI → 다중 자산 담보 (ETH, USDC 등) |
| 담보비율 | 200% | DAI → 150% (+ 자동 청산 강화) |
| 페깅 보호 | BTS 하락만 대응 | DAI → PSM(Peg Stability Module)으로 양방향 보호 |
| 유동성 | BitShares DEX (극소) | DAI → Curve, Uniswap 등 대형 DEX 유동성 |
| 최후 수단 | Global Settlement (비상 정지) | DAI → Emergency Shutdown 개선 |

**BitUSD의 실패가 MakerDAO(DAI)의 설계에 직접적 영향을 미쳤다.** DAI가 다중 담보, PSM, 충분한 DEX 유동성을 확보한 것은 BitUSD의 실패에서 배운 결과다.

---

## 강의 포인트

> "최초의 스테이블코인 BitUSD는 4년 만에 영구 디페깅되었습니다. 변동성 자산 하나에 의존한 담보, 유동성 부족, 비대칭적 보호 메커니즘이 원인이었습니다. 하지만 이 실패가 없었다면 DAI의 다중 담보 설계도, USDC의 법정화폐 담보 모델도 나오지 않았을 것입니다. 모든 성공한 스테이블코인은 BitUSD의 실패 위에 서 있습니다."

---

## 참고 자료

- [The Block — BitUSD hasn't had its $1 peg for more than two months](https://www.theblock.co/linked/11876/bitusd-hasnt-had-its-1-peg-for-more-than-two-months)
- [Medium — The Rise and Fall of the First Stablecoins: BitUSD and NuBits](https://medium.com/@yakhat86/the-rise-and-fall-of-the-first-stablecoins-bitusd-and-nubits-1efc020a7ae8)
- [CryptoNews — BitUSD Divorces Wildly From $1 Target](https://cryptonews.net/news/altcoins/68241/)
- [Coinchange — Lessons from Failed Stablecoins](https://www.coinchange.io/blog/the-rise-and-fall-of-stablecoins-lessons-from-the-history-of-failed-stablecoins)
- [GitHub — BSIP58: Global Settlement Protection](https://github.com/bitshares/bsips/issues/135)
- [Steemit — BitShares Global Settlement](https://steemit.com/bitshares/@lukestokes/bitshares-global-settlement-and-chain-freeze)
