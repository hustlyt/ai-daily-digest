#!/bin/bash
set -e

echo "=== AI Daily Digest 部署设置 ==="

# 检查参数
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "用法: ./setup.sh <GITHUB_USERNAME> <REPO_NAME>"
    echo "示例: ./setup.sh tao ai-daily-digest"
    exit 1
fi

GITHUB_USER=$1
REPO_NAME=$2

echo "1. 初始化 Git 仓库..."
git init
git add .
git commit -m "Initial commit"

echo "2. 创建 GitHub 仓库..."
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push

echo "3. 设置 Cloudflare Secrets..."
echo "请输入 Cloudflare Account ID:"
read -s CF_ACCOUNT_ID
gh secret set CLOUDFLARE_ACCOUNT_ID --body "$CF_ACCOUNT_ID"

echo "请输入 Cloudflare API Token:"
read -s CF_API_TOKEN
gh secret set CLOUDFLARE_API_TOKEN --body "$CF_API_TOKEN"

echo "✅ 完成！推送代码后将自动部署到 Cloudflare Pages"
echo ""
echo "后续步骤:"
echo "1. 登录 Cloudflare Dashboard"
echo "2. 创建 Pages 项目，选择 'Connect to Git'"
echo "3. 选择此仓库，框架预设选 'Astro'"
echo "4. 构建命令: npm run build"
echo "5. 输出目录: dist"
