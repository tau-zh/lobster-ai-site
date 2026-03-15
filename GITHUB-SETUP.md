# GitHub + Vercel 部署指南

## 步骤 1：创建 GitHub 仓库

1. 访问 [github.com](https://github.com)
2. 点击右上角 "+" → "New repository"
3. 仓库名：`lobster-site`（或你喜欢的名字）
4. 设为 **Public**（Vercel 免费计划需要）
5. 不要初始化（我们已有代码）
6. 点击 "Create repository"

## 步骤 2：推送代码

在终端执行（替换为你的 GitHub 用户名）：

```bash
cd /Users/siwei/.openclaw/workspace/site

# 配置 Git 用户（首次使用）
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# 添加远程仓库（替换 YOUR_USERNAME）
git remote add origin https://github.com/YOUR_USERNAME/lobster-site.git

# 推送
git branch -M main
git push -u origin main
```

## 步骤 3：部署到 Vercel

1. 访问 [vercel.com](https://vercel.com)
2. 用 GitHub 账号登录
3. 点击 "Add New Project"
4. 选择 `lobster-site` 仓库
5. 点击 "Deploy"
6. 等待 30 秒完成

## 步骤 4：绑定域名

等 `aiworker.help` 实名认证完成后：

1. Vercel 项目 → Settings → Domains
2. 添加 `aiworker.help`
3. 在域名注册商配置 DNS：
   - `A` 记录 `@` → `76.76.21.21`
   - `CNAME` 记录 `www` → `cname.vercel.com`
4. 等待 DNS 生效（5-30 分钟）

## 验证部署

部署完成后，访问：
- Vercel 提供的链接：`https://lobster-site.vercel.app`
- 或自定义域名：`https://aiworker.help`

## 后续更新

```bash
# 修改文件后
cd /Users/siwei/.openclaw/workspace/site
git add .
git commit -m "更新说明"
git push
# Vercel 会自动重新部署
```
