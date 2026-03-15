#!/usr/bin/env bash

# 🦞 龙虾 AI 一键部署工具 (macOS)
# 双击此文件自动运行

# 设置窗口标题
echo -ne "\033]0;龙虾 AI 一键部署工具\007"

# 清屏
clear

echo ""
echo "========================================"
echo "  🦞 龙虾 AI 一键部署工具"
echo "========================================"
echo ""

# 检查配置文件
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [[ ! -f "config.json" ]]; then
    echo "[错误] 未找到配置文件 config.json"
    echo "请确保此文件与部署工具在同一目录"
    echo ""
    read -p "按回车键退出..."
    exit 1
fi

echo "[✓] 配置文件找到"
echo ""

# 解析配置
API_KEY=$(grep -o '"api_key"[[:space:]]*:[[:space:]]*"[^"]*"' config.json | cut -d'"' -f4)
BASE_URL=$(grep -o '"base_url"[[:space:]]*:[[:space:]]*"[^"]*"' config.json | cut -d'"' -f4)
MODEL=$(grep -o '"model"[[:space:]]*:[[:space:]]*"[^"]*"' config.json | cut -d'"' -f4)
SOCIAL=$(grep -o '"social"[[:space:]]*:[[:space:]]*"[^"]*"' config.json | cut -d'"' -f4)

echo "[✓] 配置读取成功"
echo "    API Key: ${API_KEY:0:6}...${API_KEY: -4}"
echo "    模型：$MODEL"
echo ""

# 检查网络连接
echo "正在检查网络连接..."
if ! ping -c 1 -W 1 raw.githubusercontent.com > /dev/null 2>&1; then
    echo "[警告] 网络连接可能不稳定"
    echo "如果部署失败，请检查网络后重试"
    echo ""
fi

# 执行部署脚本
echo "========================================"
echo "  开始部署"
echo "========================================"
echo ""
echo "这可能需要 2-5 分钟，请稍候..."
echo ""

curl -fsSL "https://raw.githubusercontent.com/openclaw/openclaw/main/site/scripts/install-lobster-cn.sh" | bash -s -- \
    --api-key "$API_KEY" \
    --base-url "$BASE_URL" \
    --model "$MODEL" \
    --social "$SOCIAL"

if [[ $? -ne 0 ]]; then
    echo ""
    echo "[错误] 部署失败"
    echo "请查看错误信息，或联系支持"
    echo ""
    read -p "按回车键退出..."
    exit 1
fi

echo ""
echo "========================================"
echo "  ✅ 部署完成！"
echo "========================================"
echo ""
echo "📍 访问地址：http://localhost:18789"
echo ""
echo "📁 安装目录：~/lobster-ai"
echo "📄 配置文件：~/lobster-ai/.env"
echo ""
echo "如配置了社交软件，配置文件位于："
echo "  ~/lobster-ai/config/social/"
echo ""
echo "按回车键退出..."
read -r
