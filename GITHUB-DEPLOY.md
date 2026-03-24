# 🚀 GitHub + Vercel 自动部署指南

通过 GitHub 和 Vercel 集成，实现**推送代码后自动部署**，无需手动操作！

---

## 📋 准备工作

- GitHub 账号
- Vercel 账号（可以用 GitHub 账号直接登录）

---

## 🔧 步骤 1：创建 GitHub 仓库

### 选项 A：使用 GitHub 网页（推荐新手）

1. 访问 [github.com/new](https://github.com/new)
2. 填写仓库名称，例如：`lobster-ai-site`
3. 选择 **Public** 或 **Private**（都可以免费部署）
4. **不要** 勾选"Add README"
5. 点击 **"Create repository"**

### 选项 B：使用命令行

```bash
# 创建新仓库（需要 gh CLI）
gh repo create lobster-ai-site --public --source=. --remote=origin --push
```

---

## 🔧 步骤 2：推送代码到 GitHub

创建仓库后，在终端执行：

```bash
# 进入网站目录
cd /Users/siwei/.openclaw/workspace

# 添加 GitHub 远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin git@github.com:YOUR_USERNAME/lobster-ai-site.git

# 或者使用 HTTPS（如果没配置 SSH）
git remote add origin https://github.com/YOUR_USERNAME/lobster-ai-site.git

# 推送代码
git branch -M main
git push -u origin main
```

---

## 🔧 步骤 3：在 Vercel 连接 GitHub

1. **访问 Vercel**：[vercel.com](https://vercel.com)
2. **登录**：使用 GitHub 账号登录（最方便）
3. **添加新项目**：
   - 点击 **"Add New..."** → **"Project"**
4. **导入 GitHub 仓库**：
   - 在"Import Git Repository"下找到你的 `lobster-ai-site` 仓库
   - 点击 **"Import"**
5. **配置项目**（保持默认即可）：
   - **Framework Preset**: `Other`
   - **Build Command**: `echo 'No build needed - static site'`
   - **Output Directory**: `site`（如果仓库根目录就是 site 内容，留空）
   - **Install Command**: `echo 'No install needed'`
6. **点击 "Deploy"**

---

## 🎉 完成！

部署成功后，Vercel 会给你一个域名，例如：
```
https://lobster-ai-site.vercel.app
```

**以后每次 `git push` 都会自动部署！**

---

## 🔄 日常使用

```bash
# 修改网站文件后
cd /Users/siwei/.openclaw/workspace

# 提交更改
git add .
git commit -m "更新 API Key 教程截图"

# 推送到 GitHub（自动触发 Vercel 部署）
git push
```

等待 1-2 分钟，访问你的 Vercel 域名即可看到更新！

---

## ⚙️ 高级配置

### 自定义域名

1. 在 Vercel 项目页面，点击 **"Settings"** → **"Domains"**
2. 添加你的域名，按提示配置 DNS

### 环境变量

如果网站需要 API Key 等敏感信息：
1. 在 Vercel 项目页面，点击 **"Settings"** → **"Environment Variables"**
2. 添加变量，例如：`API_KEY=sk-xxxxx`
3. 重新部署

### 预览部署

- 每次推送到**非 main 分支**都会创建预览部署
- 可用于测试新功能，确认后再合并到 main

---

## ❓ 常见问题

### Q: 推送后没有自动部署？
- 检查 Vercel 项目的 Git 集成是否启用
- 查看 Vercel 的"Deployments"标签页了解部署状态

### Q: 部署失败怎么办？
- 在 Vercel 查看部署日志
- 确认 `vercel.json` 配置正确
- 检查文件路径和引用是否正确

### Q: 如何回滚到之前的版本？
- 在 Vercel 的"Deployments"页面找到之前的成功部署
- 点击"..." → "Promote to Production"

---

## 📚 相关资源

- [Vercel 文档](https://vercel.com/docs)
- [GitHub 入门](https://docs.github.com/en/get-started)
- [静态网站最佳实践](https://vercel.com/guides/deploying-a-static-website-with-vercel)
