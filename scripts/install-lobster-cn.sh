#!/usr/bin/env bash
set -euo pipefail

# 🦞 龙虾 AI 一键部署脚本
# 用法：curl -fsSL <script-url> | bash -s -- --api-key "sk-xxx" --base-url "https://..." --model "qwen-max"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() { printf "${BLUE}[INFO]${NC} %s\n" "$1"; }
log_success() { printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"; }
log_warn() { printf "${YELLOW}[WARN]${NC} %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$1"; }

# 解析参数
API_KEY=""
BASE_URL=""
MODEL=""
SOCIAL=""
INSTALL_DIR="$HOME/lobster-ai"

while [[ $# -gt 0 ]]; do
  case $1 in
    --api-key) API_KEY="$2"; shift 2 ;;
    --base-url) BASE_URL="$2"; shift 2 ;;
    --model) MODEL="$2"; shift 2 ;;
    --social) SOCIAL="$2"; shift 2 ;;
    --install-dir) INSTALL_DIR="$2"; shift 2 ;;
    *) log_warn "未知参数：$1"; shift ;;
  esac
done

# 检查必填参数
if [[ -z "$API_KEY" ]]; then
  log_error "缺少必填参数：--api-key"
  echo "用法：curl -fsSL <script-url> | bash -s -- --api-key \"sk-xxx\" --base-url \"https://...\" --model \"qwen-max\""
  exit 1
fi

if [[ -z "$BASE_URL" ]]; then
  log_error "缺少必填参数：--base-url"
  exit 1
fi

if [[ -z "$MODEL" ]]; then
  log_error "缺少必填参数：--model"
  exit 1
fi

log_info "=========================================="
log_info "🦞 龙虾 AI 一键部署脚本"
log_info "=========================================="
echo ""

# 检查系统
log_info "检查系统环境..."
OS_TYPE=$(uname -s)
OS_VERSION=""

case $OS_TYPE in
  Linux*)
    log_info "检测到 Linux 系统"
    # 检测 Linux 发行版
    if [[ -f /etc/os-release ]]; then
      source /etc/os-release
      OS_VERSION="$NAME $VERSION_ID"
      log_info "发行版：$OS_VERSION"
    fi
    ;;
  Darwin*)
    log_info "检测到 macOS 系统"
    OS_VERSION=$(sw_vers -productVersion)
    log_info "版本：macOS $OS_VERSION"
    
    # 检查 macOS 版本 >= 10.15
    local major_ver=$(echo $OS_VERSION | cut -d'.' -f1)
    local minor_ver=$(echo $OS_VERSION | cut -d'.' -f2)
    if [[ $major_ver -lt 10 ]] || [[ $major_ver -eq 10 && $minor_ver -lt 15 ]]; then
      log_error "macOS 版本过低（需要 10.15 或更高），当前：$OS_VERSION"
      log_error "请升级 macOS 后重试"
      exit 1
    fi
    ;;
  *)
    log_error "不支持的系统：$OS_TYPE"
    exit 1
    ;;
esac

# 检查并安装 git
check_git() {
  if command -v git >/dev/null 2>&1; then
    log_success "Git 已安装：$(git --version)"
  else
    log_warn "Git 未安装，尝试安装..."
    case $OS_TYPE in
      Linux*)
        if command -v apt >/dev/null 2>&1; then
          sudo apt update && sudo apt install -y git || { log_error "Git 安装失败"; exit 1; }
        elif command -v yum >/dev/null 2>&1; then
          sudo yum install -y git || { log_error "Git 安装失败"; exit 1; }
        elif command -v pacman >/dev/null 2>&1; then
          sudo pacman -S --noconfirm git || { log_error "Git 安装失败"; exit 1; }
        else
          log_error "无法自动安装 Git，请手动安装后重试"
          exit 1
        fi
        log_success "Git 安装完成"
        ;;
      Darwin*)
        log_info "尝试安装 Xcode Command Line Tools..."
        xcode-select --install 2>/dev/null || {
          log_warn "Xcode CLI 可能已安装或需要手动安装"
          log_warn "请访问 App Store 安装 Xcode 后重试"
        }
        # 等待用户安装
        sleep 5
        if ! command -v git >/dev/null 2>&1; then
          log_error "Git 安装未完成，请运行 xcode-select --install 后重试"
          exit 1
        fi
        log_success "Git 安装完成"
        ;;
    esac
  fi
}

# 检查并安装 Node.js
check_node() {
  if command -v node >/dev/null 2>&1; then
    local node_ver=$(node --version)
    log_success "Node.js 已安装：$node_ver"
    
    # 检查版本 >= 18
    local node_major=$(echo $node_ver | cut -d'v' -f2 | cut -d'.' -f1)
    if [[ $node_major -lt 18 ]]; then
      log_warn "Node.js 版本过低（需要 >= 18），当前：$node_ver"
    fi
  else
    log_warn "Node.js 未安装，尝试安装..."
    case $OS_TYPE in
      Linux*)
        if command -v curl >/dev/null 2>&1; then
          curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
          sudo apt install -y nodejs
          log_success "Node.js 安装完成"
        else
          log_error "无法自动安装 Node.js，请手动安装后重试"
          exit 1
        fi
        ;;
      Darwin*)
        if command -v brew >/dev/null 2>&1; then
          brew install node
          log_success "Node.js 安装完成"
        else
          log_error "请先安装 Homebrew: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
          exit 1
        fi
        ;;
    esac
  fi
}

# 检查并安装 pnpm
check_pnpm() {
  if command -v pnpm >/dev/null 2>&1; then
    log_success "pnpm 已安装：$(pnpm --version)"
  else
    log_warn "pnpm 未安装，尝试安装..."
    if command -v npm >/dev/null 2>&1; then
      npm install -g pnpm
      log_success "pnpm 安装完成"
    else
      log_error "npm 不可用，无法安装 pnpm"
      exit 1
    fi
  fi
}

# 创建安装目录
setup_dir() {
  log_info "创建安装目录：$INSTALL_DIR"
  mkdir -p "$INSTALL_DIR"
  cd "$INSTALL_DIR"
  log_success "目录准备完成"
}

# 克隆或更新代码
clone_repo() {
  local REPO_URL="https://github.com/openclaw/openclaw.git"
  
  if [[ -d ".git" ]]; then
    log_info "检测到已有代码，尝试更新..."
    git pull --rebase
    log_success "代码更新完成"
  else
    log_info "克隆代码仓库..."
    git clone "$REPO_URL" .
    log_success "代码克隆完成"
  fi
}

# 安装依赖
install_deps() {
  log_info "安装项目依赖（这可能需要几分钟）..."
  pnpm install --frozen-lockfile 2>/dev/null || pnpm install
  log_success "依赖安装完成"
}

# 配置环境变量
setup_env() {
  log_info "配置环境变量..."
  
  # 备份已有 .env
  if [[ -f ".env" ]]; then
    cp .env .env.backup.$(date +%Y%m%d%H%M%S)
    log_info "已备份原有 .env 文件"
  fi
  
  # 写入配置
  cat > .env <<EOF
# 🦞 龙虾 AI 配置
# 自动生成于 $(date '+%Y-%m-%d %H:%M:%S')

# 大模型 API 配置
DASHSCOPE_API_KEY="${API_KEY}"
OPENAI_BASE_URL="${BASE_URL}"
MODEL_NAME="${MODEL}"

# 服务配置
PORT=18789
HOST=127.0.0.1

# 社交软件集成（可选）
# SOCIAL_INTEGRATION="${SOCIAL}"

# 其他配置
NODE_ENV=production
EOF

  log_success "环境变量配置完成"
  
  # 显示配置摘要（隐藏敏感信息）
  local key_preview="${API_KEY:0:6}...${API_KEY: -4}"
  log_info "配置摘要："
  echo "  API Key: $key_preview"
  echo "  Base URL: $BASE_URL"
  echo "  Model: $MODEL"
  if [[ -n "$SOCIAL" ]]; then
    echo "  社交集成：$SOCIAL"
  fi
}

# 配置社交软件集成
setup_social() {
  if [[ -z "$SOCIAL" ]]; then
    log_info "未配置社交软件集成"
    return
  fi
  
  log_info "配置社交软件集成：$SOCIAL"
  
  # 创建社交配置目录
  mkdir -p "$INSTALL_DIR/config/social"
  
  # 创建配置说明文件
  cat > "$INSTALL_DIR/config/social/README.md" <<'EOF'
# 社交软件配置说明

## 飞书 (Feishu)

1. 登录飞书开放平台：https://open.feishu.cn/
2. 创建企业自建应用
3. 获取 App ID、App Secret、Verification Token
4. 编辑 `feishu.json` 填入配置

## QQ

1. 安装 go-cqhttp：https://docs.go-cqhttp.org/
2. 配置 QQ 机器人
3. 编辑 `qq.json` 填入配置

## 微信

推荐使用企业微信：
1. 登录企业微信管理后台
2. 创建自建应用
3. 获取 CorpID、Secret 等
4. 编辑 `wechat.json` 填入配置

详细教程请访问：https://github.com/openclaw/openclaw
EOF

  # 根据选择创建配置文件模板
  if [[ "$SOCIAL" == *"feishu"* ]]; then
    cat > "$INSTALL_DIR/config/social/feishu.json" <<EOF
{
  "enabled": false,
  "type": "feishu",
  "name": "飞书",
  "config": {
    "app_id": "请填写飞书应用 ID",
    "app_secret": "请填写飞书应用密钥",
    "verification_token": "请填写验证令牌"
  }
}
EOF
    log_info "飞书配置模板已创建：config/social/feishu.json"
  fi
  
  if [[ "$SOCIAL" == *"qq"* ]]; then
    cat > "$INSTALL_DIR/config/social/qq.json" <<EOF
{
  "enabled": false,
  "type": "qq",
  "name": "QQ",
  "config": {
    "qq_bot_path": "请填写 QQ 机器人路径",
    "qq_user_token": "请填写用户 Token"
  }
}
EOF
    log_info "QQ 配置模板已创建：config/social/qq.json"
  fi
  
  if [[ "$SOCIAL" == *"wechat"* ]]; then
    cat > "$INSTALL_DIR/config/social/wechat.json" <<EOF
{
  "enabled": false,
  "type": "wechat",
  "name": "微信",
  "config": {
    "wechat_bot_path": "请填写微信机器人路径",
    "wechat_token": "请填写 Token"
  }
}
EOF
    log_info "微信配置模板已创建：config/social/wechat.json"
  fi
  
  log_info "社交软件配置模板已创建，请根据 README.md 说明填写具体配置"
}

# 启动服务
start_service() {
  log_info "启动龙虾 AI 服务..."
  
  # 检查端口是否被占用
  if command -v lsof >/dev/null 2>&1; then
    if lsof -i :18789 >/dev/null 2>&1; then
      log_warn "端口 18789 已被占用，尝试停止旧进程..."
      lsof -ti :18789 | xargs kill -9 2>/dev/null || true
    fi
  fi
  
  # 后台启动
  nohup pnpm start > lobster.log 2>&1 &
  local PID=$!
  
  # 等待服务启动
  log_info "等待服务启动（约 10 秒）..."
  sleep 10
  
  # 检查进程是否还在运行
  if ps -p $PID > /dev/null; then
    log_success "服务启动成功！进程 ID: $PID"
  else
    log_error "服务启动失败，请查看日志：lobster.log"
    exit 1
  fi
}

# 显示完成信息
show_complete() {
  echo ""
  log_info "=========================================="
  log_success "🎉 龙虾 AI 部署完成！"
  log_info "=========================================="
  echo ""
  echo "📍 访问地址："
  echo "   http://localhost:18789"
  echo ""
  echo "📋 常用命令："
  echo "   查看日志：tail -f $INSTALL_DIR/lobster.log"
  echo "   停止服务：pkill -f 'lobster' 或 pkill -f 'openclaw'"
  echo "   重启服务：cd $INSTALL_DIR && pnpm start"
  echo ""
  echo "📁 安装目录：$INSTALL_DIR"
  echo "📄 配置文件：$INSTALL_DIR/.env"
  echo ""
  
  if [[ -n "$SOCIAL" ]]; then
    echo "🔧 社交软件集成："
    echo "   配置文件位于：$INSTALL_DIR/config/social/"
    echo "   请根据实际平台要求填写配置后重启服务"
    echo ""
  fi
  
  log_info "祝你使用愉快！遇到问题请访问：https://github.com/openclaw/openclaw"
}

# 主流程
main() {
  check_git
  check_node
  check_pnpm
  setup_dir
  clone_repo
  install_deps
  setup_env
  setup_social
  start_service
  show_complete
}

# 执行
main
