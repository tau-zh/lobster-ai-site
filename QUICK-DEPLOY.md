# ⚡ 快速部署到 Vercel（5 分钟搞定）

## 🎯 目标
把更新后的 API Key 教程部署到线上，让所有人都能看到！

---

## 📝 步骤（按顺序执行）

### 1️⃣ 添加 SSH Key 到 GitHub

**打开浏览器访问**：[github.com/settings/keys/new](https://github.com/settings/keys/new)

- **Title**: `Siwei's Mac Mini`
- **Key**: 粘贴下面的内容（已复制到剪贴板）：
  ```
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBmiK3RLOX3P0pBZIO/ApHQQIhotkCgI7TZ449I9CuPA siwei@mac-mini
  ```
- 点击 **"Add SSH key"**

---

### 2️⃣ 创建 GitHub 仓库

**打开浏览器访问**：[github.com/new](https://github.com/new)

- **Repository name**: `lobster-ai-site`
- **Description**: `龙虾 AI 打工人官网`
- **Public** ✅
- **不要** 勾选"Add README"
- 点击 **"Create repository"**

---

### 3️⃣ 推送代码

在终端执行以下命令：

```bash
cd /Users/siwei/.openclaw/workspace

# 配置 Git 用户信息（如果之前没配置过）
git config --global user.name "Siwei"
git config --global user.email "siwei@users.noreply.github.com"

# 添加 GitHub 远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin git@github.com:YOUR_USERNAME/lobster-ai-site.git

# 推送代码
git branch -M main
git push -u origin main
```

⚠️ **注意**：把 `YOUR_USERNAME` 换成你的 GitHub 用户名！

---

### 4️⃣ 在 Vercel 部署

**打开浏览器访问**：[vercel.com](https://vercel.com)

1. **登录**：点击"Sign Up"，选择"Continue with GitHub"
2. **添加项目**：点击"Add New..." → "Project"
3. **导入仓库**：找到 `lobster-ai-site`，点击"Import"
4. **配置**（保持默认）：
   - Framework Preset: `Other`
   - Build Command: `echo 'No build needed - static site'`
   - Output Directory: `site`
   - Install Command: `echo 'No install needed'`
5. **点击 "Deploy"** 🚀

---

### 5️⃣ 完成！

部署成功后，你会看到：
- ✅ 绿色的"Ready"状态
- 🌐 你的网站域名：`https://lobster-ai-site-xxxx.vercel.app`

**点击域名即可访问网站！**

---

## 🔄 以后如何更新？

```bash
# 修改文件后
cd /Users/siwei/.openclaw/workspace

# 提交并推送
git add .
git commit -m "更新内容说明"
git push
```

Vercel 会**自动部署**，等待 1-2 分钟即可看到更新！

---

## 💡 提示

- **自定义域名**：在 Vercel Settings → Domains 添加
- **查看部署状态**：访问 Vercel 项目页面
- **回滚版本**：在 Vercel Deployments 页面选择之前的版本

---

## ❓ 需要帮助？

遇到问题？在 Telegram 群组提问！
