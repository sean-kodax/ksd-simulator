# 스테이블코인의 구조와 활용 — 강의 자료

---

# Part 1: 과거 — 유래와 개념, 큰 사건들

---

## 1-1. 스테이블코인은 왜 만들어졌는가?

### 해결하려는 문제: 변동성의 저주

2013~2014년, 비트코인은 이미 $1,000를 돌파했지만 치명적인 결함이 있었다.

```
오늘 1 BTC = $1,000
내일 1 BTC = $700  (-30%)
다음 주 1 BTC = $1,200  (+70%)
```

이런 자산으로는:
- **결제 불가** — 커피를 사는 동안 가격이 바뀐다
- **거래 불편** — 암호화폐 거래소에서 법정화폐 입출금이 느리고 어렵다
- **상거래 불가** — 판매자가 가격을 책정할 수 없다

트레이더와 사용자들에게 절실하게 필요한 것이 있었다:
**블록체인의 속도와 편의성**을 가지면서, **달러처럼 안정적인 가치**를 가진 자산.

### 아이디어의 씨앗: J.R. Willett (2012)

2012년 1월, J.R. Willett이 "The Second Bitcoin Whitepaper"를 발표한다. 비트코인 네트워크 위에 새로운 규칙의 화폐 레이어를 만들 수 있다는 제안이었다. 이 논문에는 예언적인 문장이 담겨 있다:

> *"If you think Bitcoin has a reputation problem for money laundering now, just wait until you can store 'USDCoins' in the block chain!"*

**"블록체인 위의 달러"라는 아이디어가 세상에 처음 등장한 순간이다.**

이 아이디어는 2013년 Mastercoin 프로젝트로 구현된다. 비트코인 블록체인 위에 "2차 레이어"를 얹어 새로운 토큰을 만드는 프로토콜이었다.

### 최초의 시도: BitUSD (2014.7)

세계 최초의 스테이블코인은 **BitUSD**다.

- **창시자:** Dan Larimer (이후 EOS 창시자) + Charles Hoskinson (이후 Cardano 창시자)
- **체인:** BitShares 블록체인
- **방식:** 암호자산 담보형 — BitShares(BTS) 토큰을 담보로 예치하고 달러 페깅 토큰 발행
- **아이디어:** "변동성 있는 암호화폐를 과잉 담보로 잡으면, 안정적인 토큰을 만들 수 있다"

하지만 실패한다. 2018년에 $0.80까지 디페깅. 근본적 결함은 **변동성 있는 자산으로 안정적 자산을 보증**하려 한 것이다. 담보(BTS) 가격이 급락하면 페깅이 무너졌다.

### 진짜 답: Tether/USDT (2014.10)

같은 해, 훨씬 단순한 접근이 등장한다.

- 2014.7: Brock Pierce, Reeve Collins, Craig Sellars가 **Realcoin** 발표
- Craig Sellars는 Mastercoin Foundation의 CTO — Willett의 아이디어와 직접 연결된다
- 2014.10.6: 비트코인 블록체인 위에 최초 토큰 발행 (Mastercoin 프로토콜 사용)
- 2014.11.20: Realcoin → **Tether**로 리브랜딩

방식은 천재적으로 단순했다:

```
은행에 $1 입금 → USDT 1개 발행
USDT 1개 제출 → 은행에서 $1 인출
```

BitUSD의 실패를 봤기 때문이다. 변동성 자산 담보가 아닌 **진짜 달러**를 은행에 넣어두는 방식. "1 USDT = 은행 금고의 $1"이라는 단순한 약속이 트레이더들에게 즉시 채택되었다.

---

## 1-2. 프로그래머블 달러의 탄생

### 이더리움이 바꾼 것 (2015)

Tether는 "블록체인 위의 달러"를 만들었다. 하지만 할 수 있는 것은 전송과 보유뿐이었다. 비트코인 체인은 단순 전송만 지원했기 때문이다.

**2015년, 이더리움이 출시되면서 게임이 바뀐다.**

이더리움은 블록체인 위에서 프로그램(**스마트 컨트랙트**)을 실행할 수 있는 플랫폼이다. 그리고 **ERC-20**이라는 토큰 표준이 만들어진다.

ERC-20이 정의하는 핵심 함수:

```solidity
transfer(to, amount)           // 전송
approve(spender, amount)       // 다른 컨트랙트에 사용 권한 부여
transferFrom(from, to, amount) // 권한 받은 컨트랙트가 대신 전송
```

핵심은 `approve` + `transferFrom` 조합이다. 이 두 함수 덕분에:
- 사람이 직접 돈을 보내는 것뿐 아니라
- **스마트 컨트랙트가 조건에 따라 자동으로 돈을 움직일 수 있게 되었다**

이것이 "프로그래머블 머니"의 본질이다:

```
전통 달러:       은행 영업시간에 → 사람이 → 은행에 지시 → 전송
프로그래머블 달러: 24/7 → 코드가 → 조건 충족 시 자동 → 즉시 전송
```

### MakerDAO와 DAI (2017.12)

이더리움 위에서 최초의 프로그래머블 스테이블코인이 탄생한다.

- ETH를 스마트 컨트랙트에 담보로 예치 → DAI 자동 발행
- 담보 비율 150% 이상 유지 필수
- 담보 비율이 최소선 이하로 떨어지면 → 스마트 컨트랙트가 자동 청산
- **사람의 개입 없이 코드만으로 발행/관리/청산이 이루어지는 달러**

2019년 11월에는 Multi-Collateral DAI가 출시되어 ETH 외에도 다양한 자산을 담보로 사용할 수 있게 되었다.

### USDC의 등장 (2018.9)

Circle과 Coinbase가 합작하여 USDC를 출시한다.

- Tether의 "법정화폐 담보" 모델 + 이더리움의 "ERC-20 프로그래밍"을 결합
- Tether와의 차별점: **투명성** — 월간 준비금 attestation 공개, 감사 기관의 검증
- ERC-20 기반이므로 모든 이더리움 스마트 컨트랙트와 즉시 호환

### 조합성의 폭발: DeFi Summer (2020)

프로그래머블 스테이블코인의 진짜 위력이 폭발한 시점이다.

2020년 6월, Compound 프로토콜이 COMP 토큰 보상을 시작한다:

```
USDC를 Compound에 예치 → 이자 수령 + COMP 토큰 보상
→ 받은 COMP를 다시 예치 → 추가 수익
→ 수익률 300~1000% APY
```

이것이 **DeFi Summer**다. 스테이블코인이 단순한 "안정적 자산"에서 **"수익을 만드는 레고 블록"**으로 변한 순간이다.

**조합성(Composability):**

```
Layer 1: USDC를 보유
Layer 2: Aave에 예치 → 이자 수령
Layer 3: 예치 증명서(aUSDC)를 Curve에 넣음 → 추가 수수료 수익
Layer 4: Curve LP 토큰으로 다시 다른 프로토콜에... → 수익 중첩
```

각 프로토콜이 ERC-20 표준을 따르기 때문에 서로 아무 허락 없이 조합이 가능하다. 은행에서는 A은행 예금을 B은행 담보로 쓸 수 없지만, DeFi에서는 가능하다.

---

## 1-3. 스테이블코인의 3가지 유형

| 유형 | 원리 | 대표 | 장점 | 위험 |
|------|------|------|------|------|
| **법정화폐 담보형** | 1코인당 $1 준비금 보유 | USDC, USDT | 가장 안정적 | 중앙화, 준비금 리스크 |
| **암호자산 담보형** | ETH 등을 과잉 담보로 예치 | DAI | 탈중앙화 | 자본 비효율, 담보 가격 변동 |
| **알고리즘형** | 알고리즘으로 공급량 조절 | UST (Terra) | 자본 효율적 | **극도로 위험** |

---

## 1-4. 사건 1 — Terra/UST 붕괴 (2022.5)

### 무엇이었나

Terra는 알고리즘형 스테이블코인이다. 담보 없이 두 개의 토큰(UST + LUNA) 간의 차익거래 메커니즘으로 $1 페깅을 유지하려 했다.

| 항목 | 수치 |
|------|------|
| UST 최고 시총 | $17.5B (3위 스테이블코인) |
| LUNA 최고 가격 | $116 (2022.4) |
| Anchor Protocol 예치 비중 | UST 전체의 75% |
| Anchor 이자율 | **연 20%** (Terraform Labs가 보조금으로 지급) |

Anchor Protocol에서 UST를 예치하면 연 20% 이자를 받을 수 있었다. 이 이자가 사용자를 끌어모았고, UST의 75%가 Anchor에 예치되어 있었다. 하지만 이 20%는 어디서도 오지 않는 돈이었다. Terraform Labs가 자기 자금으로 보조하고 있었을 뿐이다.

### 무엇이 일어났나

**5/7 (토) — 방아쇠**
- 고래(whale) 추적 봇이 감지: **UST 85M이 한꺼번에 USDC로 스왑**됨 (Curve 풀)
- Anchor Protocol에서 대규모 인출 시작
- UST $1.00 → $0.985 소폭 이탈. 아직 대부분은 "일시적 디페깅"으로 인식

**5/8 (일) — 방어 시도**
- Luna Foundation Guard(LFG)가 **$1.5B 비트코인 비상 투입** 선언
- Do Kwon이 트위터에 올린 악명 높은 트윗:

> **"Deploying more capital — steady lads"**

이 트윗은 이후 암호화폐 역사상 가장 유명한 밈이 된다. 자신감 넘치는 한 마디 뒤에 $40B 붕괴가 기다리고 있었기 때문이다.

**5/9 (월) — 공포의 시작**
- Anchor에서 하루에 **$5B 인출** (전체 예치금 $14B의 35%)
- UST $0.35까지 급락
- LUNA $30 이하로 폭락 (한 달 전 $116)
- Death Spiral 본격 시작

**5/11 — Anchor 사실상 붕괴**
- 누적 인출 **$11B** 돌파
- LUNA $1 이하로 추락

**5/12-13 (목-금) — 종말**
- LUNA 가격 96% 추가 하락 → $0.10 이하
- 거래소들 LUNA 거래 정지
- 다음 날 LUNA 사실상 **$0** (0.0001 이하)
- UST $0.10 이하
- **총 $40B+ 시가총액 증발. 3일 만에.**

### 왜 붕괴했나: Death Spiral

```
UST 매도 압력
→ 1 UST를 $1 어치 LUNA로 교환(소각)하여 차익거래
→ LUNA 공급 폭증
→ LUNA 가격 하락
→ UST 1개를 소각해도 $1 어치 LUNA를 받을 수 없게 됨
→ 차익거래 메커니즘 자체가 붕괴
→ 페깅 복원 불가
→ 추가 패닉
→ Death Spiral (사망 나선)
```

### 개인 투자자 피해

Reddit r/TerraLuna에 올라온 글들:

> *"I lost all my life savings. Had bought Luna at $85, not sure what to do."*

> *"I lost my life savings in the investments of (LUNA UST). The worst thing is that 3 weeks ago I proposed to my girlfriend. She doesn't know anything. I lost 62 thousand dollars."*

> *"I'm lost, about to commit suicide in a chair."*

Reddit 관리자가 서브레딧 상단에 **자살예방 핫라인 번호를 고정**해야 했다.

은퇴 자금을 $100+ LUNA에 투자한 후 전액 소멸. 결혼 자금을 UST에 넣고 20% 이자를 받으려다 전액 소멸. 개발도상국에서 송금·저축 수단으로 Terra를 사용하던 가정이 하루아침에 모든 것을 잃었다.

### 연쇄 파산 — 도미노 효과

Terra 붕괴는 단독 사건으로 끝나지 않았다. $40B 소멸이 만든 신용 경색이 업계 전체를 강타했다:

```
2022.5   Terra/UST 붕괴 ($40B)
   ↓
2022.6   Three Arrows Capital (3AC) 파산
         — $10B 규모 헤지펀드, Terra 노출로 채무 불이행
   ↓
2022.6   Celsius Network 거래 동결 (6/12)
         — 3AC에 대출해줬던 자금 회수 불가 → 7/13 Chapter 11
   ↓
2022.7   Voyager Digital 거래 동결 (7/1) → Chapter 11 (7/5)
         — 3AC에 $650M+ 대출, 회수 불가
   ↓
2022.7   BlockFi 유동성 위기
   ↓
2022.11  FTX/Alameda Research 붕괴
         — Terra 연쇄 파산으로 약해진 시장에 최후의 일격
```

하나의 알고리즘 스테이블코인 붕괴가 헤지펀드 → 대출 플랫폼 → 거래소까지 연쇄적으로 무너뜨렸다.

### Do Kwon의 결말

- 2023.3.23: **몬테네그로에서 위조 여권으로 도주 중 체포**
- 미국 법정에서 상품 사기, 증권 사기, 전신 사기 공모 유죄 인정
- 2025.12: **15년 실형** 선고
- 판사의 판결문: **"epic, generational scale의 사기"**

### 교훈

- **담보 없는 스테이블코인은 구조적으로 Bank Run에 취약하다**
- 지속 불가능한 수익률(20% APY)이 $17.5B의 자금을 끌어모았고, 빠져나가는 순간 모든 것이 무너졌다
- 하나의 프로토콜 붕괴가 업계 전체에 연쇄 파산을 일으킬 수 있다
- 이 사건 이후 알고리즘형 스테이블코인에 대한 신뢰가 사실상 소멸

### 참고 자료

- [Harvard Law — Anatomy of a Run: The Terra Luna Crash](https://corpgov.law.harvard.edu/2023/05/22/anatomy-of-a-run-the-terra-luna-crash/)
- [GetBlock — Full Timeline of Events](https://getblock.net/en/articles/how-the-terra-ecosystem-collapsed-full-timeline-of-events)
- [BlockApps — In-Depth Analysis of UST Collapse](https://blockapps.net/blog/what-caused-the-depeg-of-terrausd-an-in-depth-analysis-of-its-collapse/)
- [DOJ — Do Kwon Sentencing](https://www.justice.gov/usao-sdny/pr/crypto-enabled-fraudster-sentenced-orchestrating-40-billion-fraud)

---

## 1-5. 사건 2 — SVB 사태와 USDC 디페깅 (2023.3)

### 무엇이 일어났나

"담보형도 안전하지 않다"는 것을 보여준 사건이다.

| 항목 | 수치 |
|------|------|
| SVB에 예치된 Circle 준비금 | **$3.3B** (전체의 8%) |
| USDC 최저 가격 | **$0.87** (3/11 새벽 2시) |
| 1시간 최대 거래소 유출 | **$1.2B** (3/11 오전 1시) |
| Curve 3pool 거래량 (3/11) | **$6.03B** (역대 최대) |
| Uniswap 거래량 (3/11) | **$11.9B** (역대 최대) |
| 3일간 USDC 순소각 | **$4B+** |

### 시간대별 타임라인

**3/10 (금) 오전 — SVB 파산**
- 11:37 AM ET: FDIC가 SVB를 접수(receivership)
- USDC는 아직 $1.00 유지 — Circle과 SVB의 관계가 아직 알려지지 않음

**3/10 (금) 밤 10시 — 폭탄 공개**
- Circle이 공식 발표: **"준비금 중 $3.3B가 SVB에 있다"**
- 즉시 매도 시작
- USDC $1.00 → $0.98 → $0.95... 급속 하락

**3/10 (금) 밤 ~ 3/11 (토) 새벽 — DEX 전쟁**

Curve의 3pool (USDC + USDT + DAI) 풀에서 극적인 장면이 벌어진다:

```
정상 상태: USDC 33% / USDT 33% / DAI 33%
   ↓
3/10 밤 8시부터: 모든 사람이 USDC → USDT로 스왑
   ↓
3/11 새벽: USDT 비중이 1% 이하로 고갈!
            USDC가 풀의 95% 이상을 차지
            → USDC를 USDT로 바꾸려면 거대한 슬리피지
            → 사실상 USDC를 "정상 가격"으로 팔 수 없는 상태
```

이것이 **DeFi에서의 Bank Run**이다. 전통 은행에서 ATM 앞에 줄을 서는 대신, DEX 풀의 유동성이 한쪽으로 쏠리는 것으로 나타난다.

**3/11 (토) 새벽 2시 — 최저점 $0.87**
- CEX(중앙화 거래소) 시간당 유출 $1.2B
- Curve 하루 거래량 **$6.03B** (역대 최대)
- Uniswap 하루 거래량 **$11.9B** (역대 최대)

**3/11-12 (토-일) — 차익거래자의 등장**
- 일부 트레이더들이 "미 정부가 SVB 예금을 보호할 것"에 베팅
- $0.87~0.95에 USDC 대량 매수
- **"$0.87에 사서 $1.00에 환매하면 15% 수익"** — 차익거래 메커니즘 작동
- 서서히 가격 회복

**3/12 (일) 저녁 — 반전**
- 미 재무부 + Fed + FDIC 공동 발표: **SVB 예금 전액 보호**
- Circle: "준비금 $3.3B는 월요일 아침에 전액 회수 가능"

**3/13 (월) — 복귀**
- USDC $1.00으로 복귀
- Circle: USDC는 "1:1로 계속 환매 가능"

### Terra와의 결정적 차이

| | Terra/UST | SVB/USDC |
|---|-----------|----------|
| 디페깅 원인 | 구조적 결함 (담보 없음) | 외부 사건 (은행 파산) |
| 차익거래 | 메커니즘 자체가 붕괴 | 정상 작동 ($0.87 매수 → $1 환매) |
| 환매 보장 | 불가능해짐 | Circle이 계속 보장 |
| 결과 | **영구 붕괴 ($0)** | **3일 만에 복귀 ($1.00)** |
| 피해 규모 | $40B+ 소멸 | 일시적 디페깅, 시총 $1.9B 감소 |

같은 디페깅이지만 결과가 정반대인 이유: **실물 준비금의 유무**. USDC는 준비금이 있었기에 차익거래가 작동했고, Terra는 없었기에 영원히 $0이 되었다.

### 사후 변화

- Circle 준비금 재구성: **87%를 BlackRock 관리 미국 단기 국채 펀드**로 이전
- 은행 예금 비중 대폭 축소 → 은행 파산 리스크 차단
- 이 경험이 GENIUS Act 등 스테이블코인 규제 입법을 촉발

### 직접 확인하기

- [CoinGecko USDC 차트 — $0.87 급락 구간](https://www.coingecko.com/en/coins/usdc?chart=type%3Dprice%26mode%3Dline%26from%3D1678374000000%26to%3D1678719599999)
- [Dune Analytics — USDC 순발행량 차트](https://dune.com/rencryptofish/usdc-supply-mint-burn): 차트 왼쪽의 아래로 깊게 내려간 막대 클러스터가 SVB 구간. 3/10~3/31 동안 매일 $5억~$12억 순소각
- [Circle 공식 발표 — "$3.3B USDC Reserve Risk Removed"](https://www.circle.com/pressroom/3-3-billion-of-usdc-reserve-risk-removed-dollar-de-peg-closes) (2023.3.13)
- [Chainalysis — Crypto Market Reaction to SVB](https://www.chainalysis.com/blog/crypto-market-usdc-silicon-valley-bank/)
- [Federal Reserve — Lessons from SVB's Impact on Stablecoins](https://www.federalreserve.gov/econres/notes/feds-notes/in-the-shadow-of-bank-run-lessons-from-the-silicon-valley-bank-failure-and-its-impact-on-stablecoins-20251217.html)
- [CNBC — USDC Breaks Dollar Peg](https://www.cnbc.com/2023/03/11/stablecoin-usdc-breaks-dollar-peg-after-firm-reveals-it-has-3point3-billion-in-svb-exposure.html)

---

## 1-6. 스테이블코인 역사 타임라인

```
2012.1  J.R. Willett — "블록체인 위의 USDCoin" 아이디어 제안
   ↓
2014.7  BitUSD — 최초 스테이블코인 (암호자산 담보형) → 이후 실패
2014.10 Tether(USDT) — 법정화폐 담보형, 비트코인 체인 발행
   ↓                                              ← 단순 토큰화 시대
2015    이더리움 출시 — 스마트 컨트랙트 + ERC-20 표준
   ↓                                              ← 프로그래머블 시대 개막
2017.12 MakerDAO/DAI — 최초 프로그래머블 스테이블코인
2018.9  USDC 출시 — Circle + Coinbase, 투명성 강화
   ↓
2019.11 Multi-Collateral DAI — 다양한 담보 자산 지원
   ↓                                              ← 조합성의 시대
2020.6  DeFi Summer — Compound, Curve, Aave 폭발적 성장
        스테이블코인이 DeFi의 "기축 화폐"로 자리잡음
   ↓                                              ← 시련의 시대
2022.5  Terra/UST 붕괴 — 알고리즘형의 구조적 한계 증명 ($40B 소멸)
2023.3  SVB/USDC 디페깅 — 담보형의 준비금 리스크 노출 ($0.87)
   ↓                                              ← 인프라의 시대
2025.5  CCTPv2 — 크로스체인 네이티브 전송 (Burn & Mint)
2025.5  x402 프로토콜 — HTTP 네이티브 스테이블코인 결제
2025.7  GENIUS Act 서명 — 미국 스테이블코인 법제화
2025.6  Circle IPO — NYSE 상장 (CRCL)
2026    시총 $315B+, AI 에이전트 결제, 토큰화 자산의 기축
```
