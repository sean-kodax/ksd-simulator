---
marp: true
theme: default
paginate: true
size: 16:9
style: |
  :root {
    --color-primary: #00B870;
    --color-primary-light: #00E08A;
    --color-dark: #1A1A1A;
    --color-gray: #5F6B72;
    --color-gray-light: #8C969C;
    --color-red: #E2574C;
    font-family: 'Pretendard', 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
    color: #1A1A1A;
  }
  section {
    background: #FFFFFF;
    padding: 60px 80px;
  }
  section::after {
    color: #8C969C;
    font-size: 14px;
  }
  h1 {
    color: #00B870;
    font-size: 2.2em;
    border-bottom: none;
    margin-bottom: 0.3em;
  }
  h2 {
    color: #1A1A1A;
    font-size: 1.6em;
    border-bottom: none;
  }
  h3 {
    color: #5F6B72;
    font-size: 1.1em;
  }
  strong {
    color: #00B870;
  }
  table {
    font-size: 0.75em;
    margin: 0 auto;
  }
  table th {
    background: #00B870;
    color: #FFFFFF;
    font-weight: 600;
  }
  table td {
    border-color: #E8EAED;
  }
  code {
    background: #F4F5F6;
    color: #1A1A1A;
    font-size: 0.85em;
  }
  pre {
    background: #F4F5F6;
    border-left: 4px solid #00B870;
    font-size: 0.7em;
  }
  blockquote {
    border-left: 4px solid #00B870;
    color: #5F6B72;
    font-style: italic;
    background: #F0FBF6;
    padding: 12px 20px;
    font-size: 0.85em;
  }
  .breadcrumb {
    position: absolute;
    top: 24px;
    left: 80px;
    font-size: 0.65em;
    color: #8C969C;
  }
  section.title {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    background: linear-gradient(135deg, #FFFFFF 0%, #F0FBF6 100%);
  }
  section.title h1 {
    font-size: 3.2em;
    margin-bottom: 0.1em;
  }
  section.title h3 {
    color: #5F6B72;
    font-weight: 400;
    font-size: 1.1em;
  }
  section.divider {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    background: linear-gradient(135deg, #00B870 0%, #00E08A 100%);
    color: #FFFFFF;
  }
  section.divider h1 {
    color: #FFFFFF;
    font-size: 2.8em;
  }
  section.divider h3 {
    color: rgba(255,255,255,0.85);
    font-weight: 400;
    font-size: 1.1em;
  }
  section.divider::after {
    color: rgba(255,255,255,0.5);
  }
  .red { color: #E2574C; }
  .green { color: #00B870; }
  .gray { color: #8C969C; }
  .small { font-size: 0.7em; }
  .columns { display: flex; gap: 40px; }
  .col { flex: 1; }
  em { color: #5F6B72; }
---

<!-- _class: title -->
<!-- _paginate: false -->

# 스테이블코인

### 스테이블코인 시대의 도래 | 과거, 미래, 현재 그리고 직접 체험

---

<!-- _paginate: false -->

# 강사 소개

<div class="columns">
<div class="col">

### <span class="gray">Web2</span>

<span class="gray">

네이버
&darr;
쿠팡
&darr;
토스 간편결제
&darr;
토스증권
&darr;
삼쩜삼

</span>

</div>
<div class="col" style="display:flex; flex-direction:column; justify-content:center; align-items:center;">

### &rarr; **스테이블코인** &larr;

*두 세계의 접점*

</div>
<div class="col">

### <span class="green">Web3</span>

**블록체인**
**스마트 컨트랙트**
**DeFi**
**스테이블코인**

</div>
</div>

> "Web2에서 Web3로 이직한 입장에서, 스테이블코인이야말로 Web2와 Web3가 만나는 접점이라고 느꼈습니다. 이 경계선에서, 두 세계를 연결하는 이 기술을 여러분과 함께 살펴보고자 합니다."

---

# 오늘의 흐름

| | 파트 | 내용 |
|---|---|---|
| **01** | 스테이블코인의 탄생과 시련 | 유래, 개념, 그리고 $40B이 사라진 날 |
| **02** | 왜 스테이블코인이어야 하는가 | CBDC, 예금 토큰이 아닌 이유 |
| **03** | 스테이블코인이 만드는 미래 | 기계가 돈을 쓰고, 국경이 사라지는 세상 |
| **04** | 지금, 어디까지 왔는가 | $323B 시장, GENIUS Act, 그리고 한국 |
| **05** | 직접 체험 | KSD 발행부터 x402 결제까지 |

---

<!-- _class: divider -->

# 01

### 스테이블코인의 탄생과 시련

---

<div class="breadcrumb">01 과거 · 정의</div>

# 스테이블코인이란?

**블록체인 위에서 법정화폐(USD)의 가치에 고정(peg)된 디지털 자산**

<div class="columns">
<div class="col">

### 핵심 특성

- 1 코인 = $1 가치 유지
- ERC-20 토큰 (프로그래밍 가능)
- 24/7/365 전송 가능
- 스마트 컨트랙트와 조합 가능

</div>
<div class="col">

### 2026년 5월 기준

- 전체 시총: **$323B**
- 온체인 거래량: **$46T/년**
- 달러 표시 비중: **99%**
- Visa의 **3배** 규모

</div>
</div>

---

<div class="breadcrumb">01 과거 · 탄생</div>

# 왜 만들어졌는가?

### 해결하려는 문제: 변동성의 저주

```
오늘  1 BTC = $1,000
내일  1 BTC = $700   (-30%)
다음 주     = $1,200  (+70%)
```

이런 자산으로는:

- **결제 불가** -- 커피를 사는 동안 가격이 바뀐다
- **거래 불편** -- 법정화폐 입출금이 느리고 어렵다
- **상거래 불가** -- 판매자가 가격을 책정할 수 없다

**필요한 것:** 블록체인의 속도와 편의성 + 달러처럼 안정적인 가치

---

<div class="breadcrumb">01 과거 · 역사</div>

# 아이디어에서 현실로

### J.R. Willett (2012.1)

> *"If you think Bitcoin has a reputation problem for money laundering now, just wait until you can store 'USDCoins' in the block chain!"*

**"블록체인 위의 달러"라는 아이디어가 세상에 처음 등장한 순간**

### BitUSD (2014.7) -- 최초의 스테이블코인

- Dan Larimer + Charles Hoskinson / BitShares 체인
- 암호자산 담보형: BTS를 담보로 달러 페깅 토큰 발행
- **실패**: 2018년 $0.80 디페깅. 변동성 자산으로 안정적 자산을 보증하려 한 한계

---

<div class="breadcrumb">01 과거 · 역사</div>

# Tether의 등장 (2014.10)

BitUSD의 실패를 보고 **천재적으로 단순한** 접근이 등장

```
은행에 $1 입금  →  USDT 1개 발행
USDT 1개 제출  →  은행에서 $1 인출
```

- Brock Pierce, Reeve Collins, Craig Sellars (Mastercoin CTO)
- 비트코인 블록체인 위 Mastercoin 프로토콜로 발행
- **진짜 달러**를 은행에 넣어두는 방식
- "1 USDT = 은행 금고의 $1"이라는 단순한 약속

---

<div class="breadcrumb">01 과거 · 프로그래머블 달러</div>

# 이더리움이 바꾼 것 (2015)

Tether는 전송과 보유만 가능했다. **이더리움이 게임을 바꾼다.**

### ERC-20 핵심 함수

```solidity
transfer(to, amount)            // 전송
approve(spender, amount)        // 사용 권한 부여
transferFrom(from, to, amount)  // 대신 전송
```

`approve` + `transferFrom` = **스마트 컨트랙트가 조건에 따라 자동으로 돈을 움직인다**

```
전통 달러:        은행 영업시간에 → 사람이 → 은행에 지시 → 전송
프로그래머블 달러:  24/7 → 코드가 → 조건 충족 시 자동 → 즉시 전송
```

---

<div class="breadcrumb">01 과거 · 프로그래머블 달러</div>

# MakerDAO/DAI (2017) + USDC (2018) + DeFi Summer (2020)

<div class="columns">
<div class="col">

### MakerDAO/DAI (2017.12)

- ETH 담보 예치 &rarr; DAI 자동 발행
- 150% 과잉 담보, 자동 청산
- **코드만으로 발행/관리/청산**

### USDC (2018.9)

- Circle + Coinbase 합작
- 법정화폐 담보 + ERC-20
- **월간 준비금 attestation** 공개

</div>
<div class="col">

### DeFi Summer (2020)

```
USDC를 Compound에 예치
  → 이자 + COMP 토큰
  → 받은 COMP를 재예치
  → APY 300~1000%
```

**조합성(Composability):**
```
Layer 1: USDC 보유
Layer 2: Aave 예치 → 이자
Layer 3: aUSDC를 Curve에 → 수수료
Layer 4: LP토큰으로 또 다른 프로토콜...
```

스테이블코인이 **"수익을 만드는 레고 블록"**으로

</div>
</div>

---

<div class="breadcrumb">01 과거 · 트릴레마</div>

# 스테이블코인의 3가지 유형

| 유형 | 원리 | 대표 | 장점 | 위험 |
|------|------|------|------|------|
| **법정화폐 담보형** | 1코인당 $1 준비금 보유 | USDC, USDT | 가장 안정적 | 중앙화, 준비금 리스크 |
| **암호자산 담보형** | ETH 등 과잉 담보 예치 | DAI | 탈중앙화 | 자본 비효율, 담보 변동 |
| **알고리즘형** | 알고리즘으로 공급량 조절 | UST (Terra) | 자본 효율적 | <span class="red">**극도로 위험**</span> |

### 트릴레마

**안정성**, **탈중앙화**, **자본 효율성** -- 세 가지를 동시에 만족하는 설계는 없다

- 법정화폐 담보형: 안정적 + 효율적, but 중앙화
- 암호자산 담보형: 탈중앙 + 안정적, but 비효율적
- 알고리즘형: 탈중앙 + 효율적, but <span class="red">불안정</span>

---

<div class="breadcrumb">01 과거 · Terra 붕괴</div>

# 사건 1: Terra/UST 붕괴 (2022.5)

### 알고리즘형 스테이블코인. 담보 없이 UST + LUNA 차익거래로 $1 유지

| 항목 | 수치 |
|------|------|
| UST 최고 시총 | **$17.5B** (3위 스테이블코인) |
| LUNA 최고 가격 | **$116** (2022.4) |
| Anchor Protocol 예치 | UST 전체의 **75%** |
| Anchor 이자율 | <span class="red">**연 20%**</span> (지속 불가능한 보조금) |

**Anchor에 UST를 넣으면 연 20% 이자.**
이 20%는 어디서도 오지 않는 돈이었다. Terraform Labs가 자기 자금으로 보조하고 있었을 뿐.

---

<div class="breadcrumb">01 과거 · Terra 붕괴</div>

# 72시간의 기록

| 날짜 | 사건 |
|------|------|
| **5/7 (토)** | 고래가 UST $85M을 USDC로 스왑. Anchor 대규모 인출 시작. UST $0.985 |
| **5/8 (일)** | LFG가 **$1.5B 비트코인** 투입 선언 |
| **5/9 (월)** | Anchor **하루 $5B 인출** (35%). UST **$0.35**. LUNA $30 이하 |
| **5/11** | 누적 인출 **$11B**. LUNA **$1 이하** |
| **5/12-13** | LUNA **$0** (0.0001 이하). UST $0.10 이하 |

> **"Deploying more capital -- steady lads"** -- Do Kwon (5/8)
> 자신감 넘치는 한 마디 뒤에 $40B 붕괴가 기다리고 있었다

---

<div class="breadcrumb">01 과거 · Terra 붕괴</div>

# Death Spiral (사망 나선)

```
UST 매도 압력
  → 1 UST를 $1 어치 LUNA로 교환(소각)하여 차익거래
  → LUNA 공급 폭증
  → LUNA 가격 하락
  → UST 1개를 소각해도 $1 어치 LUNA를 받을 수 없게 됨
  → 차익거래 메커니즘 자체가 붕괴
  → 페깅 복원 불가 → 추가 패닉
  → Death Spiral (사망 나선)
```

**총 $40B+ 시가총액 증발. 3일 만에.**

---

<div class="breadcrumb">01 과거 · Terra 붕괴</div>

# 개인 투자자 피해와 연쇄 파산

<div class="columns">
<div class="col">

### 투자자 피해

Reddit r/TerraLuna에 올라온 글들:

> *"I lost all my life savings. Had bought Luna at $85."*

> *"I lost 62 thousand dollars. My girlfriend doesn't know."*

Reddit 관리자가 **자살예방 핫라인 번호를 고정**

</div>
<div class="col">

### 연쇄 파산 (도미노)

```
2022.5  Terra/UST ($40B)
   ↓
2022.6  3AC 파산 ($10B)
   ↓
2022.6  Celsius 동결 → Ch.11
   ↓
2022.7  Voyager 동결 → Ch.11
   ↓
2022.11 FTX 붕괴 — 최후의 일격
```

</div>
</div>

### Do Kwon의 결말

몬테네그로에서 위조 여권으로 도주 중 체포 &rarr; **15년 실형** | 판사: *"epic, generational scale의 사기"*

---

<div class="breadcrumb">01 과거 · SVB/USDC</div>

# 사건 2: SVB 사태와 USDC 디페깅 (2023.3)

### "담보형도 안전하지 않다"는 것을 보여준 사건

| 항목 | 수치 |
|------|------|
| SVB에 예치된 Circle 준비금 | **$3.3B** (전체의 8%) |
| USDC 최저 가격 | <span class="red">**$0.87**</span> (3/11 새벽 2시) |
| 1시간 최대 유출 | **$1.2B** |
| Curve 3pool 거래량 (3/11) | **$6.03B** (역대 최대) |
| 3일간 USDC 순소각 | **$4B+** |

---

<div class="breadcrumb">01 과거 · SVB/USDC</div>

# SVB 사태 타임라인

| 시점 | 사건 | USDC 가격 |
|------|------|-----------|
| 3/10 (금) 오전 | FDIC가 SVB 접수 | $1.00 |
| 3/10 (금) 밤 10시 | Circle 발표: "준비금 $3.3B가 SVB에" | $0.98 &darr; |
| 3/11 (토) 새벽 | Curve 3pool: USDC 95%, USDT 1% 이하 | <span class="red">**$0.87**</span> |
| 3/11-12 (토-일) | 차익거래자 매수: "$0.87에 사서 $1에 환매 = 15%" | $0.90 &uarr; |
| 3/12 (일) 저녁 | 미 재무부+Fed+FDIC: **SVB 예금 전액 보호** | $0.98 &uarr; |
| 3/13 (월) | USDC $1.00 복귀 | **$1.00** |

**DeFi에서의 Bank Run:** ATM 앞 줄 대신 DEX 풀의 유동성이 한쪽으로 쏠린다

---

<div class="breadcrumb">01 과거 · SVB/USDC</div>

# Terra vs USDC: 같은 디페깅, 반대의 결과

| | Terra/UST | SVB/USDC |
|---|-----------|----------|
| 디페깅 원인 | 구조적 결함 (담보 없음) | 외부 사건 (은행 파산) |
| 차익거래 | 메커니즘 **붕괴** | 정상 작동 ($0.87 &rarr; $1) |
| 환매 보장 | 불가능 | Circle이 계속 보장 |
| 결과 | <span class="red">**영구 붕괴 ($0)**</span> | <span class="green">**3일 만에 복귀 ($1.00)**</span> |
| 피해 규모 | $40B+ 소멸 | 일시적 디페깅 |

**핵심: 실물 준비금의 유무.** USDC는 준비금이 있었기에 차익거래가 작동했고, Terra는 없었기에 영원히 $0.

### 사후 변화

Circle 준비금 재구성: **87%를 BlackRock 관리 미국 단기 국채 펀드**로 이전

---

<!-- _class: divider -->

# 02

### 왜 스테이블코인이어야 하는가

---

<div class="breadcrumb">02 왜 스테이블코인 · 비교</div>

# 후보군 비교: 왜 기존 시스템으로는 안 되는가

<div class="columns">
<div class="col">

### 기존 결제 (카드, SWIFT)

- 프로그래밍 불가
- 영업시간 제한
- 중개자 3~4단계, 수수료 높음
- 마이크로페이먼트 불가
- AI 에이전트 사용 불가

</div>
<div class="col">

### CBDC (중앙은행 디지털 화폐)

- 허가형(Permissioned) 폐쇄 네트워크
- 국가 단위, 크로스보더 불가
- DeFi 조합 불가
- 프라이버시 우려
- 나이지리아 eNaira 채택률 6%, 디지털 위안 후퇴

</div>
<div class="col">

### 예금 토큰 (JPM Coin)

- JP모건 고객만 사용 (KYC 필수)
- 폐쇄형 네트워크
- 다른 은행 토큰과 비호환
- AI 에이전트 사용 불가

</div>
</div>

---

<div class="breadcrumb">02 왜 스테이블코인 · 결론</div>

# 법정화폐 담보형 스테이블코인이 우위인 이유

### 4가지 속성의 교차점

| 속성 | 기존 결제 | CBDC | 예금 토큰 | **스테이블코인** |
|------|----------|------|----------|--------------|
| 안정성 | O | O | O | **O** (실물 담보) |
| 개방성 | X | X | X | **O** (무허가, 글로벌) |
| 프로그래밍 | X | X | 제한적 | **O** (스마트 컨트랙트) |
| 이미 작동 중 | O | X (파일럿) | 제한적 | **O** ($323B, $46T 거래) |

> "CBDC는 아직 파일럿이고, 예금 토큰은 은행 안에 갇혀 있고, 기존 결제는 기계가 못 쓴다. **스테이블코인만이 지금, 글로벌하게, 프로그래밍 가능한 형태로 작동하고 있다.**"

---

<div class="breadcrumb">02 왜 스테이블코인 · 달러 패권</div>

# 스테이블코인은 달러 패권의 도구

```
스테이블코인 발행 확대 → 준비금으로 미 국채 매입 → 미 국채 수요 증가 → 달러 가치 유지
```

- Tether + Circle 미 국채 보유: **$1,449B** -- 한국($120B)의 **12배**
- 1년간 **1,295%** 증가
- 중국이 미 국채 축소하는 빈자리를 스테이블코인 발행사가 채우고 있다

기축 통화 평균 수명 ~100년. **달러는 이미 105년째.**
스테이블코인을 통한 "디지털 달러화"는 기축 통화 지위 연장 전략

> 미 재무장관 스콧 베센트 (2025.3): **"스테이블코인 기술로 달러의 기축 통화 지위를 유지할 것"**

---

<!-- _class: divider -->

# 03

### 스테이블코인이 만드는 미래

---

<div class="breadcrumb">03 미래 · 국경 없는 송금</div>

# 국경이 사라지는 송금

### $10,000 송금 비용 비교

| 방식 | 수수료 | 소요 시간 | 절감률 |
|------|--------|----------|--------|
| SWIFT (수수료+환전) | $390 | 3~5 영업일 | - |
| 신용카드 (2.5%) | $250 | 1~3일 | - |
| **스테이블코인 (~0.55%)** | **$55** | **수 초~3분** | **85.9%** |

### 이미 일어나고 있는 변화

- 2025년 B2B 스테이블코인 결제: **$226B** (전년 대비 733% 성장)
- 필리핀 해외 근로자 송금 수수료: 6% &rarr; **~1%** (연 $38.3B)
- 전 세계 **14억 명** 은행 계좌 없음. 하지만 스마트폰은 있다

---

<div class="breadcrumb">03 미래 · AI 에이전트</div>

# 기계가 기계에게 돈을 내는 세상

### AI 에이전트 경제 -- 이미 시작되었다 (2025.5~2026.4)

| 항목 | 수치 |
|------|------|
| AI 에이전트 트랜잭션 | **1.76억 건** |
| 총 결제 금액 | **$73M** |
| USDC 비중 | **98.6%** |
| 평균 결제 금액 | **$0.31~$0.48** |

### x402 프로토콜: HTTP 402 Payment Required

```
AI 에이전트:  GET /api/weather-data
서버:         402 Payment Required {"price": "$0.001", "token": "USDC"}
AI 에이전트:  (자동으로 USDC $0.001 결제)
서버:         200 OK + 데이터 제공
```

계정 없이, 구독 없이, **결제만으로 접근.** Gartner: 2030년 기계 고객이 전체 구매의 **20%**, **$30T**

---

<div class="breadcrumb">03 미래 · 스트리밍 급여</div>

# 초 단위 급여 + Pay-Per-Use

<div class="columns">
<div class="col">

### 스트리밍 페이먼트

연봉 $60,000 = 초당 **$0.0019**

```
09:00  출근 → 급여 스트림 시작
12:00  오전 근무분 $95.04 이미 지갑에
13:00  점심 = 오전 급여로 결제
18:00  퇴근 → $190.08 수령 완료
```

- Superfluid, Sablier, Zebec 운영 중
- Deel: 2026.5 스테이블코인 급여 정식 출시

</div>
<div class="col">

### 구독의 종말: Pay-Per-Use

| 현재 | 미래 |
|------|------|
| 넷플릭스 월 $15.49 | 영화 1편 $0.99 |
| NYT 연 $120 | 기사 1개 $0.10 |
| Spotify 월 $10.99 | 곡당 $0.005 |

**마이크로페이먼트**가 가능해지면
구독 강요도, 광고도 필요 없다

- Cloudflare **NetDollar**: AI 크롤러 실시간 소액결제
- Meta: 크리에이터 페이아웃 탐색 중

</div>
</div>

---

<div class="breadcrumb">03 미래 · RWA + 그림자</div>

# 토큰화된 세상의 기축 화폐 + 감시와 통제

<div class="columns">
<div class="col">

### 실물 자산 토큰화 (RWA)

- 2026.5 기준 **$32B+** (전년 대비 200%)
- 토큰화된 국채, 부동산, 주식, 채권
- 결제 수단 = 스테이블코인
- Mastercard가 BVNK 인수 (2026.3)

> 맨해튼 빌딩 0.001% 지분 $50에 구매.
> 매달 임대료 $0.12 자동 입금.
> 최소 투자금은 $1.

</div>
<div class="col">

### 양날의 검: 감시와 통제

**자유의 도구:**
- 14억 명에게 은행 없이 달러
- 독재 국가에서 자산 보호
- 국경 없는 즉시 전송

<span class="red">**통제의 도구:**</span>
- `blacklist` 함수로 원격 자산 동결
- 모든 거래 블록체인에 영구 기록
- 정부 요청 시 발행사 협조

> *프로그래머블 머니는 프로그래머블 감시이기도 하다*

</div>
</div>

---

<!-- _class: divider -->

# 04

### 지금, 어디까지 왔는가

---

<div class="breadcrumb">04 현재 · 시장 현황</div>

# 시장 현황 (2026.5)

<div class="columns">
<div class="col">

### 핵심 숫자

| 항목 | 수치 |
|------|------|
| 전체 시총 | **$323B** |
| USDT | $189.6B (58.3%) |
| USDC | $77.6B (2025년 73% 성장) |
| 온체인 거래량 | $46T/년 |
| 암호화폐 거래 중 비중 | 75% |

</div>
<div class="col">

### 결제 처리량 비교 (2025)

```
스테이블코인   $46T  ████████████████
Visa          $15T  █████
Mastercard     $9T  ███
PayPal         $2T  █
```

**Visa의 3배.**
실제 결제(B2B/송금/커머스)만 **$390B**

</div>
</div>

---

<div class="breadcrumb">04 현재 · ChatGPT Moment</div>

# "ChatGPT Moment" -- Citi Institute

AI가 ChatGPT로 변곡점을 맞이한 것처럼, 스테이블코인도 **지수적 성장의 변곡점에 진입**

### 2030년 시총 전망

| 기관 | 전망치 |
|------|--------|
| J.P. Morgan | $500B |
| Goldman Sachs | $1T |
| **Citi Institute** | **$1.6T** |
| TABC (미 재무부 자문위) | $2T (2028년) |

현재 $323B &rarr; Citi 전망 $1.6T = **5배 성장** 필요
2024&rarr;2025 USDC 기준 73% 성장 감안하면 비현실적이지 않다

---

<div class="breadcrumb">04 현재 · Tether 수익</div>

# Tether의 수익 모델

### 직원 ~100명인 회사가 2024년 순이익 $13B

**수익 3가지 원천:**

1. **투자 수익:** 미 국채 $1,200B 보유 (세계 19위 미 국채 보유자)
2. **수수료:** 법정화폐&rarr;USDT 전환 시 0.1% (최소 $100,000)
3. **대출 수익:** USDT 담보 대출 (투명성 우려)

### 구조적 수익 비교

| | 전통 은행 | 스테이블코인 발행사 |
|---|---------|-----------------|
| 예금 비용 | 10% (이자 지급) | **0%** (이자 금지) |
| 대출 수익 | 20% | 20% |
| 마진 | 10% | **20%** (2배) |

---

<div class="breadcrumb">04 현재 · Yield-Bearing</div>

# 이자형(Yield-Bearing) 스테이블코인

"이자를 주는 달러"에 대한 수요 폭발

| 토큰 | 발행사 | 수익 원천 | 수익률 | 특징 |
|------|--------|----------|--------|------|
| **USDe** | Ethena | 파생상품 펀딩비, 베이시스 | 10~30%+ | 높은 수익, 높은 리스크 |
| **USDS** | Sky (MakerDAO) | 미 국채, 암호자산 담보 | ~5% | 과잉 담보, 상대적 안전 |
| **BUIDL** | BlackRock | 미 국채, RP | ~4.5% | SEC Reg.D, 가장 안전 |

### 트럼프의 USD1

- World Liberty Financial (WLF) 발행, 시총 ~$3B (5위)
- 트럼프 가문이 운영수익 75%, 토큰 판매 60% 수취
- 대통령 가문이 스테이블코인을 발행한다는 것 자체가, 시장의 전략적 중요성을 방증

---

<div class="breadcrumb">04 현재 · USDT vs USDC</div>

# USDT vs USDC -- 두 거인의 경쟁

| | USDT (Tether) | USDC (Circle) |
|---|------|------|
| 시총 | $189.6B (1위) | $77.6B (2위) |
| 2025 성장률 | 36% | **73%** |
| 투명성 | 분기 보고 (제한적) | **월간 attestation** |
| 규제 준수 | 비규제 | **MiCA 최초 준수**, GENIUS Act 준비 |
| 강점 | 시장 점유율, 유동성 | 투명성, 규제, 기관 신뢰 |

### 시장의 방향

- 규제 이전: "누가 더 많이 발행하나" &rarr; USDT 압도적
- 규제 이후: "누가 규제를 준수하나" &rarr; USDC 추격
- MiCA 시행 후 유럽 USDC 거래량 **337% 급증**
- **"규제 준수 = 경쟁 우위"의 시대**

---

<div class="breadcrumb">04 현재 · GENIUS Act</div>

# GENIUS Act (2025.7.18 서명)

### 미국 최초의 스테이블코인 연방법

| 항목 | 내용 |
|------|------|
| 정의 | "지급결제용 스테이블코인" -- 고정 가치 유지, 환매 의무 |
| 감독 기관 | OCC, Federal Reserve, FDIC, Treasury |
| 준비금 | 1:1 고품질 유동 자산(HQLA) -- **3개월 미만 미 국채** |
| 공시 | **월간 준비금 attestation** 공개 의무 |
| 이자 지급 | <span class="red">**금지**</span> |
| AML/제재 | BSA 금융기관 분류, 자금세탁방지 프로그램 의무 |
| 주(州) 규제 | $10B 이하는 주 차원 면허 가능 |

**GENIUS Act가 바꾸는 것:**
- 스테이블코인이 **법적으로 정의**된 자산 클래스
- "규제 회색 지대" 소멸 &rarr; 기관 채택 가속
- 해외 발행사에도 동등한 규제 적용

---

<div class="breadcrumb">04 현재 · 글로벌 규제</div>

# 글로벌 규제 비교

| 항목 | 미국 (GENIUS Act) | EU (MiCA) | 일본 (PSA) | 한국 |
|------|------------------|-----------|-----------|------|
| 법적 형태 | 스테이블코인 전용법 | 포괄적 암호자산법 | 기존 금융법 개정 | <span class="red">**전용법 없음**</span> |
| 발행 주체 | 연방 인가 + 비은행 | 은행/전자화폐기관 | 은행/자금이동/신탁 | 미정 |
| 준비금 | 현금, 3개월 미만 국채 | EMT: 30% 분리 보관 | 요구불예금만 | 미정 |
| 이자 지급 | 금지 | 금지 | 1:1 유지 | 미정 |
| 환매권 | 보장 | 보장 | 보장 | 미정 |

한국은 주요국 중 **유일하게 전용 프레임워크 부재**

---

<div class="breadcrumb">04 현재 · 한국</div>

# 한국: 스테이블코인 규제의 공백

<div class="columns">
<div class="col">

### 국회 계류 중 8개 법안 (2025.6~11)

- 민병덕: 디지털자산기본법
- 안도걸: 가치안정형 디지털자산법
- 김은혜: 가치고정형 디지털자산법
- 김현정: 가치안정형 디지털자산법
- 이강일: 디지털자산시장법
- 김재섭: 디지털자산통합법
- 서보명: 디지털자산 육성기본법
- 박상혁: 스테이블코인법

**핵심 쟁점:** 누가 발행? 누가 감독? 원화 스테이블코인?

</div>
<div class="col">

### 시장 현황

- 거래소 스테이블코인 시총: ~5,778억원
- 월간 거래량: ~7조원
- NHN KCP: 원화 스테이블코인 상표 11종 등록

### 이재명 정부 공약 (2025.6)

- 디지털자산 기본법 제정
- 토큰증권(STO) 법제화
- 현물 ETF 도입
- **원화 스테이블코인 발행/유통** 법적 근거

### 한국은행

- Project Hangang: CBDC 파일럿 (7개 은행)
- 민간 스테이블코인 &rarr; 통화 정책 우려

</div>
</div>

---

<div class="breadcrumb">04 현재 · Circle</div>

# Circle의 사업 구조

### 2025.6 NYSE 상장 (CRCL) | 공모가 $31 &rarr; 첫날 $83.23 (+168%)

```
사용자가 $1 입금  →  Circle이 USDC 1개 발행  →  $1을 미국 국채 펀드에 예치
→  국채 이자 발생 (~4-5%)  →  63%를 파트너(Coinbase 등) 지급  →  37%가 Circle 매출
→  사용자에게 이자? → 없음 (GENIUS Act가 금지)
```

| 항목 | 2024 | 2025 |
|------|------|------|
| 매출 | $1.68B | **$2.75B** (+64%) |
| 준비금 이자 비중 | 99.1% | ~90% |
| Adj. EBITDA | $285M | **$582M** (+104%) |

은행보다 **훨씬 안전** -- 대출 없음, 국채 부도가 아닌 한 안전. 하지만 이자도 없음.
USDC를 보유하는 이유 = **프로그래밍 가능성 + 글로벌 접근성**

---

<div class="breadcrumb">04 현재 · 핵심 메시지</div>

# 결국, 신뢰다

<div class="columns">
<div class="col">

### 인프라 확장 타임라인

| 시기 | 사건 |
|------|------|
| 2025.3 | CCTPv2 크로스체인 전송 |
| 2025.5 | x402 프로토콜 출시 |
| 2025.6 | Circle IPO (NYSE) |
| 2025.7 | GENIUS Act 서명 |
| 2026.3 | Mastercard, BVNK 인수 |
| 2026.5 | Deel 스테이블코인 급여 |
| 2026.5 | Stripe AI 결제 인프라 |

</div>
<div class="col">

### 키워드

- **제도화** -- GENIUS Act + MiCA
- **기관 채택** -- Visa, Mastercard, Stripe, JPMorgan
- **인프라 시대** -- CCTPv2, x402, 급여
- **AI 경제** -- 기계가 기계에게 결제

> "2022년은 시련, 2023년은 회복, 2024년은 규제, 2025년은 제도화. **2026년은 스테이블코인이 일상에 스며드는 해.**"

</div>
</div>

---

<div class="breadcrumb">04 현재 · 토론</div>

# 토론 질문

### 여러분은 어떻게 생각하시나요?

1. **스테이블코인은 자유의 도구인가, 통제의 도구인가?**
   14억 명에게 은행 없이 달러를 주는 것 vs 특정 인물의 자산을 원격으로 동결하는 것

2. **한국은 원화 스테이블코인을 발행해야 하는가?**
   금융 혁신 vs 통화 정책 리스크

3. **USDT와 USDC, 누가 이길까?**
   양의 우위 vs 규제 준수의 우위

4. **AI가 자율적으로 돈을 쓰는 세상은 바람직한가?**
   효율성 vs 통제 가능성

---

<!-- _class: divider -->

# 05

### 직접 체험 -- KSD 발행부터 x402 결제까지

---

<div class="breadcrumb">05 실습 · 개요</div>

# 실습 흐름: 8단계로 체험하는 스테이블코인

| Step | 실습 | 연결되는 강의 |
|------|------|-------------|
| 1 | **지갑 연결 + 에어드랍** | 블록체인 지갑, 에어드랍 |
| 2 | **KSD 발행 (Mint)** | 법정화폐 담보형 발행 구조 |
| 3 | **준비금 대시보드** | 준비금의 중요성 |
| 4 | **KSD 소각 (Burn)** | 환매와 차익거래 |
| 5 | **페깅 시뮬레이션 + SVB** | 디페깅과 복원 원리 |
| 6 | **실제 USDC Mint 추적** | USDC 온체인 활동 |
| 7 | **CCTPv2 크로스체인 전송** | 국경 없는 결제 인프라 |
| 8 | **x402 결제로 수료 뱃지** | AI 에이전트 경제 |

**KSD 컨트랙트:** `0xbAa67736C4c403e35384783100e00e2DFF454f6c` (Base Sepolia)

---

<!-- _class: title -->
<!-- _paginate: false -->

# 감사합니다

### 스테이블코인이 만들어가는 새로운 금융 인프라

<br>

> "오늘 여러분은 스테이블코인의 전체 생애주기를 직접 체험했습니다.
> 달러를 입금하여 토큰을 발행하고, 준비금을 추적하고, 소각하고,
> 차익거래를 체험하고, 크로스체인 전송하고, 디지털 상품을 결제했습니다.
> **이 모든 것이 은행 없이, 영업시간 제한 없이, 코드만으로 이루어졌습니다.**"
