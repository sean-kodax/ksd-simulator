#!/bin/bash
# ==========================================
# KSD 스테이블코인 워크숍 실습 환경 구성
# ==========================================
#
# 사용법: ./start-workshop.sh
#
# 이 스크립트는 다음을 실행합니다:
# 1. x402 + 시뮬레이터 통합 서버 (포트 4021)
# 2. ngrok 터널 (외부 접속용)
# 3. CCTPv2 데모 앱 (포트 3002, 선택)
#
# 사전 준비:
# - Node.js 22+
# - ngrok 설치 및 인증
# - x402-server/node_modules 설치 (npm install)
# ==========================================

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CCTP_DIR="$SCRIPT_DIR/../circle-cctp-crosschain-transfer"

echo ""
echo "🎓 KSD 스테이블코인 워크숍 환경 구성"
echo "=========================================="
echo ""

# ===== 1. 기존 프로세스 정리 =====
echo "🧹 기존 프로세스 정리..."
lsof -ti :4021 2>/dev/null | xargs kill 2>/dev/null || true
lsof -ti :3002 2>/dev/null | xargs kill 2>/dev/null || true
pkill -f "ngrok http" 2>/dev/null || true
sleep 1

# ===== 2. x402 + 시뮬레이터 서버 시작 =====
echo "🚀 워크숍 서버 시작 (포트 4021)..."
cd "$SCRIPT_DIR/x402-server"

if [ ! -d "node_modules" ]; then
  echo "   📦 의존성 설치 중..."
  npm install
fi

node server.js &
SERVER_PID=$!
sleep 2

echo "   ✅ 서버 실행 중 (PID: $SERVER_PID)"
echo "   📍 로컬: http://localhost:4021/ksd-simulator.html"
echo ""

# ===== 3. ngrok 터널 시작 =====
echo "🌐 ngrok 터널 시작..."
ngrok http 4021 --log=stdout > /tmp/ngrok-workshop.log 2>&1 &
NGROK_PID=$!
sleep 4

NGROK_URL=$(grep -o 'url=https://[^ ]*' /tmp/ngrok-workshop.log | head -1 | sed 's/url=//')
if [ -n "$NGROK_URL" ]; then
  echo "   ✅ ngrok 실행 중 (PID: $NGROK_PID)"
  echo ""
  echo "   =========================================="
  echo "   📱 수강생 접속 URL:"
  echo "   $NGROK_URL/ksd-simulator.html"
  echo "   =========================================="
else
  echo "   ⚠️  ngrok URL을 가져오지 못했습니다. 로그 확인: /tmp/ngrok-workshop.log"
fi

echo ""

# ===== 4. CCTPv2 데모 앱 (선택) =====
read -p "🔗 CCTPv2 데모 앱도 시작할까요? (y/n): " START_CCTP
if [ "$START_CCTP" = "y" ] || [ "$START_CCTP" = "Y" ]; then
  if [ -d "$CCTP_DIR" ]; then
    echo "🚀 CCTPv2 데모 앱 시작 (포트 3002)..."
    cd "$CCTP_DIR"
    if [ ! -d "node_modules" ]; then
      echo "   📦 의존성 설치 중..."
      npm install
    fi
    PORT=3002 npm run start &
    CCTP_PID=$!
    sleep 3
    echo "   ✅ CCTPv2 앱 실행 중 (PID: $CCTP_PID)"
    echo "   📍 로컬: http://localhost:3002"
    echo ""
    echo "   ⚠️  CCTPv2 앱은 별도 ngrok 없이 로컬에서만 접근 가능합니다."
    echo "   워크숍에서는 강사 화면 공유로 시연하거나,"
    echo "   ngrok 유료 플랜이면 별도 도메인으로 터널을 추가하세요."
  else
    echo "   ⚠️  CCTPv2 앱 디렉토리를 찾을 수 없습니다: $CCTP_DIR"
    echo "   git clone https://github.com/circlefin/circle-cctp-crosschain-transfer.git"
  fi
fi

echo ""
echo "=========================================="
echo "📋 실행 중인 서비스:"
echo "   - 워크숍 서버: http://localhost:4021"
echo "   - ngrok: $NGROK_URL"
if [ -n "$CCTP_PID" ]; then
  echo "   - CCTPv2 앱: http://localhost:3002"
fi
echo ""
echo "🛑 종료하려면 Ctrl+C"
echo "=========================================="
echo ""

# ===== 종료 처리 =====
cleanup() {
  echo ""
  echo "🛑 서버 종료 중..."
  kill $SERVER_PID 2>/dev/null || true
  kill $NGROK_PID 2>/dev/null || true
  [ -n "$CCTP_PID" ] && kill $CCTP_PID 2>/dev/null || true
  echo "✅ 완료"
  exit 0
}

trap cleanup SIGINT SIGTERM

# 포그라운드 대기
wait
