#!/bin/bash
# 龙虾 AI 网站部署脚本
# 用法：./deploy-to-github.sh YOUR_GITHUB_USERNAME

set -e

if [ -z "$1" ]; then
    echo "❌ 请提供 GitHub 用户名"
    echo "用法：$0 YOUR_GITHUB_USERNAME"
    echo ""
    echo "例如：$0 siwei123"
    exit 1
fi

GITHUB_USERNAME=$1
REPO_NAME="lobster-ai-site"
REMOTE_URL="git@github.com:${GITHUB_USERNAME}/${REPO_NAME}.git"

echo "🦞 龙虾 AI 网站部署脚本"
echo "========================"
echo ""
echo "GitHub 用户名：$GITHUB_USERNAME"
echo "仓库名称：$REPO_NAME"
echo ""

# 检查 SSH key
if [ ! -f ~/.ssh/github_ed25519 ]; then
    echo "❌ 未找到 SSH key，请先运行："
    echo "   ssh-keygen -t ed25519 -C \"your@email.com\""
    echo "然后将公钥添加到 GitHub"
    exit 1
fi

echo "✅ SSH key 已找到"
echo ""

# 检查远程仓库
if git remote | grep -q "origin"; then
    echo "⚠️  已存在 origin 远程仓库"
    read -p "是否覆盖？(y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
    git remote remove origin
fi

# 添加远程仓库
echo "🔗 添加远程仓库..."
git remote add origin $REMOTE_URL
echo "✅ 远程仓库已添加：$REMOTE_URL"
echo ""

# 推送代码
echo "📤 推送代码到 GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ 推送成功！"
echo ""
echo "🎉 下一步："
echo "   1. 访问 https://github.com/${GITHUB_USERNAME}/${REPO_NAME} 确认代码已上传"
echo "   2. 访问 https://vercel.com 登录并导入此仓库"
echo "   3. Vercel 会自动部署，完成后获得你的网站域名！"
echo ""
echo "📖 详细指南：site/QUICK-DEPLOY.md"
