import express from "express";
import cors from "cors";
import { ethers } from "ethers";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const app = express();
app.use(cors());
app.use(express.json());

// ===== 정적 파일: 시뮬레이터 HTML 서빙 =====
app.use(express.static(join(__dirname, "..", "app")));

// ===== 설정 =====
const KSD_ADDRESS = "0xbAa67736C4c403e35384783100e00e2DFF454f6c";
const PAY_TO = "0x7E91884cC68ABD397A83939F69E70Df0d847A4E6";
const PRICE = 10; // 10 KSD
const DECIMALS = 6;
const RPC_URL = "https://base-sepolia-rpc.publicnode.com";

const provider = new ethers.JsonRpcProvider(RPC_URL);

// 결제 확인된 주소 저장
const paidAddresses = new Set();

// ===== GET /certificate — x402 스타일 =====
app.get("/certificate", (req, res) => {
  const payerAddress = req.headers["x-payer-address"];
  const paymentTx = req.headers["x-payment-tx"];

  // 결제 증명이 없으면 402 반환
  if (!payerAddress || !paymentTx) {
    return res.status(402).json({
      "x402-version": 1,
      description: "KSD 스테이블코인 워크숍 수료 뱃지",
      accepts: {
        token: "KSD",
        tokenAddress: KSD_ADDRESS,
        network: "Base Sepolia (84532)",
        amount: PRICE,
        payTo: PAY_TO,
      },
    });
  }

  // 이미 결제 확인된 주소
  if (paidAddresses.has(payerAddress.toLowerCase())) {
    return res.json(generateCertificate(payerAddress));
  }

  return res.status(402).json({
    error: "결제 확인 중입니다. 잠시 후 다시 시도하세요.",
  });
});

// ===== POST /verify — 결제 검증 =====
app.post("/verify", async (req, res) => {
  const { txHash, payerAddress } = req.body;

  if (!txHash || !payerAddress) {
    return res.status(400).json({ error: "txHash와 payerAddress가 필요합니다." });
  }

  try {
    const receipt = await provider.getTransactionReceipt(txHash);
    if (!receipt) {
      return res.status(404).json({ error: "트랜잭션을 찾을 수 없습니다. 아직 확인 중일 수 있습니다." });
    }

    // KSD Transfer 이벤트 파싱
    const transferTopic = ethers.id("Transfer(address,address,uint256)");
    const requiredAmount = ethers.parseUnits(String(PRICE), DECIMALS);

    let verified = false;
    for (const log of receipt.logs) {
      if (
        log.address.toLowerCase() === KSD_ADDRESS.toLowerCase() &&
        log.topics[0] === transferTopic
      ) {
        const from = ethers.getAddress("0x" + log.topics[1].slice(26));
        const to = ethers.getAddress("0x" + log.topics[2].slice(26));
        const value = BigInt(log.data);

        if (
          from.toLowerCase() === payerAddress.toLowerCase() &&
          to.toLowerCase() === PAY_TO.toLowerCase() &&
          value >= requiredAmount
        ) {
          verified = true;
          break;
        }
      }
    }

    if (verified) {
      paidAddresses.add(payerAddress.toLowerCase());
      return res.json({
        verified: true,
        certificate: generateCertificate(payerAddress),
      });
    } else {
      return res.status(400).json({
        error: `결제 검증 실패. KSD ${PRICE}개를 ${PAY_TO.slice(0, 10)}...으로 전송했는지 확인하세요.`,
      });
    }
  } catch (err) {
    console.error("Verify error:", err);
    return res.status(500).json({ error: "검증 중 오류가 발생했습니다." });
  }
});

// ===== 수료 뱃지 생성 =====
function generateCertificate(address) {
  const now = new Date();
  return {
    type: "KSD Workshop Certificate",
    title: "스테이블코인 워크숍 수료 뱃지",
    recipient: address,
    issuedAt: now.toISOString(),
    issuer: "KSD Stablecoin Workshop",
    details: {
      course: "스테이블코인의 구조와 활용",
      topics: ["Mint/Burn", "준비금", "페깅 메커니즘", "CCTPv2", "x402 결제"],
      chain: "Base Sepolia",
      paymentToken: "KSD",
      paymentAmount: PRICE,
    },
    message: `축하합니다! ${address.slice(0, 6)}...${address.slice(-4)}님이 스테이블코인 워크숍을 수료하였습니다.`,
  };
}

// ===== 서버 시작 =====
const PORT = 4021;
app.listen(PORT, () => {
  console.log(`\n🎓 KSD Workshop Server`);
  console.log(`   http://localhost:${PORT}`);
  console.log(`\n   Simulator:  http://localhost:${PORT}/ksd-simulator.html`);
  console.log(`   GET  /certificate  — 402 결제 요구 또는 뱃지 발급`);
  console.log(`   POST /verify       — KSD 결제 검증\n`);
  console.log(`   Price: ${PRICE} KSD → ${PAY_TO}\n`);
});
