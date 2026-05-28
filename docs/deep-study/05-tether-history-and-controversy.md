# Tether(USDT)의 역사와 논란

## 탄생과 성장

### 2014: Realcoin → Tether

- 2014.7: Brock Pierce, Reeve Collins, Craig Sellars가 **Realcoin** 발표
- 2014.10.6: 비트코인 Omni Layer 위에 최초 토큰 발행
- 2014.11.20: **Tether**로 리브랜딩
- 핵심 약속: **"1 USDT = 은행에 예치된 $1. 항상, 100%."**

### 지배 구조 — 누가 Tether를 소유하는가

```
iFinex Inc. (BVI 등록, 모회사)
    ├── Tether Holdings Ltd. (스테이블코인 발행)
    └── Bitfinex (암호화폐 거래소)

→ 같은 회사가 거래소와 스테이블코인을 동시에 소유
```

| 인물 | 역할 | 특이사항 |
|------|------|---------|
| **Giancarlo Devasini** | CFO, 최대주주 (~40-47%) | 전직 성형외과 의사. 2025년 자산 $22B+ (Forbes) |
| **Jan Ludovicus van der Velde** | 전 CEO (iFinex) | 초기 명목상 대표 |
| **Paolo Ardoino** | 현 CEO (2023~) | CTO에서 CEO로 승격, AI/통신 사업 확장 추진 |
| **Brock Pierce** | 공동 창립자 | 초기에 이탈, Mastercoin Foundation 출신 |

**본사:** BVI → 2025.1 **엘살바도르로 이전** 발표 (최초의 공식 본사)

---

## 논란의 역사 — 연대기

### 2016~2018: "100% 달러 보유"는 거짓이었다

Tether는 출시 때부터 "모든 USDT는 동일한 금액의 달러로 100% 보증된다"고 홍보했다. 하지만:

> **CFTC 조사 결과: 2016.6~2018년, 26개월 중 USDT가 100% 달러 보유된 날은 전체의 27.6%에 불과했다.**

나머지 72.4%의 기간 동안 USDT는 **부분지급준비금** 상태였다. 즉, 모든 보유자가 동시에 환매를 요청하면 지급 불가능한 상태.

### 2016: Bitfinex 해킹과 은폐

- 2016.8: Bitfinex가 **$72M(약 12만 BTC) 해킹** 당함
- 이후 Bitfinex는 파나마의 결제 대행사 **Crypto Capital Corp**에 $1B+ 예치
- Crypto Capital이 이 자금 중 **$850M을 횡령**
- Bitfinex가 이 손실을 메우기 위해 **Tether 준비금에서 $900M을 빼서 사용**
- Tether의 준비금이 Bitfinex의 운영 자금으로 전용됨 — 동일 모회사(iFinex) 소유이기에 가능

### 2017: 비트코인 가격 조작 의혹

텍사스 대학교 금융학 교수 **John Griffin**과 Amin Shams가 118페이지 논문 발표:
- 제목: *"Is Bitcoin Really Un-Tethered?"* (Journal of Finance 게재)
- 200GB 이상의 블록체인 데이터를 분석
- **핵심 발견:**
  - 비트코인 가격이 하락할 때 Tether가 대량 발행됨
  - 발행된 Tether가 비트코인 매수에 사용됨
  - 2017년 비트코인 가격 상승의 상당 부분이 **Bitfinex의 단일 대형 계정**에서 발생
  - "2017년 비트코인의 거의 모든 가격 상승은 하나의 대형 플레이어에 기인한다"

> **CNBC 보도: "한 명의 익명 시장 조작자가 비트코인을 $20,000까지 끌어올렸다"**

Tether는 이를 부인했지만, 이후 CFTC 제재로 준비금 부족이 사실로 확인됨.

### 2019: 뉴욕 검찰 (NYAG) 소송

- 2019.4: 뉴욕 주 검찰총장 **Letitia James**가 iFinex(Tether+Bitfinex)를 고소
- 핵심 혐의: Bitfinex가 Crypto Capital 손실 $850M을 Tether 준비금으로 메운 행위
- 조사 과정에서 Tether가 **74%만 달러로 보유**하고 있었음이 드러남

### 2021: 이중 제재

**NYAG 합의 (2021.2):**
- 벌금 **$18.5M** 지급
- 분기별 준비금 보고서 공개 의무
- 뉴욕 거주자/기관 대상 서비스 금지

**CFTC 제재 (2021.10):**
- 벌금 **$41M** — "준비금에 대한 허위 및 오해를 유발하는 진술"
- CFTC 공식 발표: "Tether는 준비금이 '완전히 보증'되어 있고 '안전하게 예치'되어 있다고 표시했지만, 사실이 아니었다"

### 2022: 준비금 구성 논란

Tether가 처음으로 준비금 구성을 공개했을 때 충격적 사실이 드러남:

```
2021년 초 Tether 준비금 구성:
  기업어음 (Commercial Paper): 49.6%  ← 가장 논란
  신탁예금: 18.4%
  현금: 3.87%
  역RP: 2.94%
  미국채: 2.94%
  기타: 22.25%
```

**기업어음 49.6%의 문제:**
- 어떤 기업의 어음인지 공개하지 않음
- 나중에 **중국 은행(건설은행, 농업은행 등)의 기업어음**이 포함되어 있었음이 드러남
- 기업어음은 미 국채보다 리스크가 높고, 유동성 위기 시 가치 하락 가능
- "100% 달러 보유"와는 거리가 먼 구성

**2022.10: Tether가 기업어음을 0으로 줄였다고 발표** — 비판 이후 미 국채 비중으로 전환

---

## 현재의 Tether (2024~2026)

논란에도 불구하고 Tether는 암호화폐 역사상 가장 수익성 높은 회사가 되었다.

### 2024년 실적

| 항목 | 수치 |
|------|------|
| 순이익 | **$13.7B** (직원 ~100명) |
| 미 국채 보유 | **$113B** → 2025 Q3 $135B+ |
| 시총 | **$189.6B** (2026.4) |
| 사용자 | **5억 명+** (2025 Q3) |
| 미 국채 보유 순위 | **세계 18위** (한국, UAE, 독일과 비슷한 수준) |

### 현재 준비금 구성 (2025)

```
미국 단기 국채 (T-Bills): ~80%
현금 및 은행 예금: ~10%
비트코인: ~5%
금: ~3%
기타 (대출 등): ~2%
```

2021년의 "기업어음 49.6%"에서 "미 국채 80%"로 극적으로 변화. 하지만 여전히 **독립적 감사(audit)는 한 번도 받은 적이 없다** — "attestation(확인)"만 받고 있으며, 이는 감사보다 훨씬 낮은 수준의 검증이다.

---

## Attestation vs Audit — 왜 중요한가

| | Attestation (확인) | Audit (감사) |
|---|-------------------|-------------|
| **수준** | 특정 시점의 특정 항목 확인 | 재무제표 전체의 적정성 검증 |
| **범위** | "이 날짜에 이 금액이 있었는가?" | "회계 처리가 전체적으로 적정한가?" |
| **Tether** | 분기별 attestation만 실시 | **한 번도 받은 적 없음** |
| **Circle** | 월간 attestation + Deloitte 감사 | S-1 제출로 SEC 수준 공시 |

> "Tether는 '우리 금고에 돈이 있다'는 사진을 보여주지만, '그 돈이 어디서 왔고 어디로 갈 수 있는지'에 대한 전체 그림은 보여주지 않습니다."

---

## 그럼에도 살아남은 이유

모든 논란에도 Tether가 시총 $189.6B로 1위를 유지하는 이유:

1. **선발 주자 이점:** 2014년부터 시작, 거래소 기축 통화 자리를 선점
2. **유동성의 자기 강화:** USDT가 가장 유동적 → 트레이더가 USDT를 쓰는 → 더 유동적이 됨
3. **신흥국 채택:** 아르헨티나, 터키, 나이지리아 등에서 인플레이션 헤지 + 송금 수단으로 일상 사용. 5억 명 사용자
4. **규제 밖 운영의 "장점":** KYC 없이 P2P 거래 가능 → 규제가 어려운 시장에서 선호
5. **수익성:** 연 $13.7B 순이익이 만드는 자본 여력. 준비금 초과분 $7B+

### GENIUS Act 이후 판이 바뀌고 있다

- 미국 시장 접근 시 준비금 공시, 감사, AML 의무 부과
- MiCA에서 USDT는 비준수 → 유럽 거래소에서 상장폐지 위험
- 규제 준수 비용이 커질수록 USDC와의 경쟁에서 구조적 불리

---

## 강의 포인트

> "Tether의 역사는 암호화폐 산업의 모순을 압축하고 있습니다. '100% 달러 보유'라고 했지만 72%의 기간 동안 거짓이었고, 비트코인 가격을 조작했다는 학술 논문이 나왔고, $60M의 벌금을 냈습니다. 그럼에도 시총 $189.6B, 순이익 $13.7B, 사용자 5억 명. 규제 밖에서 이 정도로 성장한 회사가 GENIUS Act의 규제 안으로 들어올 때 어떤 일이 벌어질까요? 이것이 스테이블코인 시장의 가장 큰 변수입니다."

---

## 참고 자료

- [CFTC — Tether and Bitfinex $42.5M Fine](https://www.cftc.gov/PressRoom/PressReleases/8450-21)
- [Fortune — Tether CEO Paolo Ardoino Q&A](https://fortune.com/crypto/2025/02/01/tether-ceo-paolo-ardoino/)
- [BeInCrypto — Tether $13B Profits, Record Treasury Holdings](https://beincrypto.com/tether-13-billion-net-profit-2024/)
- [John Griffin & Amin Shams — "Is Bitcoin Really Un-Tethered?" (SSRN)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3195066)
- [CoinDesk — Tether Banking, Commercial Paper (Legal Docs)](https://www.coindesk.com/policy/2023/06/16/tethers-banking-relationships-commercial-paper-exposure-detailed-in-newly-released-legal-documents)
- [Terminal3 — How Controversy Didn't Kill Tether](https://blog.terminal3.io/how-controversy-from-day-one-didnt-kill-tether-it-created-web3s-top-company/)
- [Wikipedia — Tether](https://en.wikipedia.org/wiki/Tether_(cryptocurrency))
- [Strident Citizen — Tether Has Never Been Audited](https://www.stridentcitizen.com/p/tether-has-never-been-audited-it)
