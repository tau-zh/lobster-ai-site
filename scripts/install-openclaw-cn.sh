#!/usr/bin/env bash
set -euo pipefail

echo "[AI打工人] 明日上线版安装器"
echo "这是演示性质的国内友好安装脚手架，用于代部署前的基础环境准备。"

action_note() { printf '\n==> %s\n' "$1"; }

action_note "检查 Docker"
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker 未安装，请先运行: curl -fsSL https://get.docker.com | sh"
  exit 1
fi

action_note "创建工作目录"
mkdir -p "$HOME/openclaw-deploy"
cd "$HOME/openclaw-deploy"

action_note "写入示例环境文件"
cat > .env.example <<'EOF'
# 复制为 .env 后自行填写
OPENAI_API_KEY=
OPENAI_BASE_URL=
MODEL_NAME=
EOF

action_note "生成下一步提示"
cat <<'EOF'
下一步：
1. 复制 .env.example 为 .env
2. 填入你的国产模型 API Key / Base URL / Model Name
3. 把服务器信息发给代部署服务继续调通
EOF

echo "完成。"
