# 📋 Vercel 部署检查清单

## 部署前检查

### 文件检查
- [x] `index.html` - 首页
- [x] `deploy.html` - 一键部署（核心）
- [x] `pricing.html` - 价格说明
- [x] `api-key-guide.html` - API Key 教程
- [x] `windows-wsl-guide.html` - Windows 安装指南
- [x] `onboarding-guide.html` - 新手入门
- [x] `faq.html` - 常见问题
- [x] `wizard.html` - 部署向导（旧版，保留）
- [x] `styles.css` - 全局样式
- [x] `vercel.json` - Vercel 配置
- [x] `scripts/` - 部署脚本目录
  - [x] `install-lobster-cn.sh`
  - [x] `一键部署.bat`
  - [x] `一键部署.command`
  - [x] `一键部署.sh`
  - [x] `README.txt`

### 功能检查
- [x] 一键部署工具（Windows/macOS/Linux）
- [x] 系统选择自动显示指南
- [x] API Key 配置
- [x] 社交软件集成选项
- [x] 价格说明（免费版/¥99 套餐）
- [ ] 智能咨询机器人（TODO）

### 导航检查
- [x] 首页导航正确
- [x] 所有页面互相链接
- [x] 外部链接（API 教程）正确

---

## Vercel 部署步骤

### 1. 创建 GitHub 仓库
```bash
cd /Users/siwei/.openclaw/workspace/site

# 配置 Git（首次使用）
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# 查看当前状态
git status
```

### 2. 推送到 GitHub
```bash
# 添加远程仓库（替换为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/lobster-site.git

# 推送
git branch -M main
git push -u origin main
```

### 3. 部署到 Vercel
1. 访问 [vercel.com](https://vercel.com)
2. GitHub 登录
3. "Add New Project"
4. 选择 `lobster-site` 仓库
5. "Deploy"
6. 等待完成（约 30 秒）

### 4. 测试部署
- [ ] 访问 Vercel 提供的链接
- [ ] 测试首页
- [ ] 测试部署页面
- [ ] 测试价格页面
- [ ] 测试 API Key 教程
- [ ] 测试下载启动器

### 5. 绑定域名（等 aiworker.help 实名认证完成）
1. Vercel → Settings → Domains
2. 添加 `aiworker.help`
3. 配置 DNS：
   - `A` 记录 `@` → `76.76.21.21`
   - `CNAME` 记录 `www` → `cname.vercel.com`
4. 等待 DNS 生效

---

## 当前状态

### 已完成
- ✅ 所有页面开发完成
- ✅ 一键部署工具实现
- ✅ 系统指南整合
- ✅ 价格页面更新
- ✅ Git 仓库初始化
- ✅ Vercel 配置创建

### 待完成
- ⏳ GitHub 仓库创建
- ⏳ 推送到 GitHub
- ⏳ Vercel 部署
- ⏳ 域名绑定（等实名认证）
- ⏳ 智能咨询机器人

---

## 快速部署命令

```bash
# 一键部署到 Vercel（需要先安装 vercel CLI）
cd /Users/siwei/.openclaw/workspace/site
npm i -g vercel
vercel login
vercel --prod
```

---

## 联系信息

- 域名：aiworker.help（实名认证中）
- GitHub: github.com/YOUR_USERNAME/lobster-site
- Vercel: lobster-site.vercel.app（待部署）
