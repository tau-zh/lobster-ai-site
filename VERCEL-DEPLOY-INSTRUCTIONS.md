# 🚀 Vercel 部署完整指南

## 前提条件

1. **GitHub 账号** - [github.com](https://github.com)
2. **Vercel 账号** - [vercel.com](https://vercel.com)（可用 GitHub 登录）
3. **域名 aiworker.help** - 等待实名认证完成

---

## 步骤 1：创建 GitHub 仓库

### 1.1 访问 GitHub
打开 [github.com/new](https://github.com/new)

### 1.2 填写信息
- **Repository name**: `lobster-site`
- **Description**: 龙虾 AI 一键部署网站
- **Public**: ✅ 选中（Vercel 免费计划需要）
- **Initialize**: ❌ 不要选中

### 1.3 创建
点击 "Create repository"

---

## 步骤 2：推送代码到 GitHub

### 2.1 配置 Git 用户（首次使用）
```bash
git config --global user.name "你的名字"
git config --global user.email "你的邮箱@example.com"
```

### 2.2 添加远程仓库
```bash
cd /Users/siwei/.openclaw/workspace/site

# 替换 YOUR_GITHUB_USERNAME 为你的 GitHub 用户名
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/lobster-site.git
```

### 2.3 推送代码
```bash
git branch -M main
git push -u origin main
```

**推送成功后**，在 GitHub 上应该能看到所有文件。

---

## 步骤 3：部署到 Vercel

### 3.1 访问 Vercel
打开 [vercel.com](https://vercel.com)

### 3.2 登录
点击 "Login" → 选择 "Continue with GitHub"

### 3.3 导入项目
1. 点击 "Add New Project"
2. 选择 "Import Git Repository"
3. 找到 `lobster-site` 仓库
4. 点击 "Import"

### 3.4 配置项目
保持默认设置：
- **Framework Preset**: Other
- **Root Directory**: `./`（留空）
- **Build Command**: 留空
- **Output Directory**: 留空
- **Install Command**: 留空

### 3.5 部署
点击 "Deploy"

**等待 30-60 秒**，部署完成后会显示：
- ✅ Deployment Complete
- 预览链接：`https://lobster-site-xxx.vercel.app`

### 3.6 访问测试
点击预览链接，测试以下页面：
- [ ] 首页正常
- [ ] 部署页面正常
- [ ] 价格页面正常
- [ ] 下载启动器正常

---

## 步骤 4：绑定自定义域名

**等 aiworker.help 实名认证完成后执行**

### 4.1 在 Vercel 添加域名
1. 进入 Vercel 项目
2. Settings → Domains
3. 点击 "Add"
4. 输入 `aiworker.help`
5. 点击 "Add"

### 4.2 配置 DNS

在你的域名注册商处（阿里云/腾讯云/Namesilo 等）添加：

| 类型 | 主机记录 | 记录值 |
|------|---------|--------|
| A | @ | 76.76.21.21 |
| CNAME | www | cname.vercel.com |

### 4.3 等待生效
- 通常 5-30 分钟生效
- 最长可能 48 小时
- 可用 [dnschecker.org](https://dnschecker.org/) 检查

### 4.4 验证
访问 `https://aiworker.help` 应该能看到网站

---

## 后续更新

### 修改代码后推送
```bash
cd /Users/siwei/.openclaw/workspace/site

# 修改文件后
git add .
git commit -m "修改说明"
git push
```

**Vercel 会自动检测推送并重新部署**，无需手动操作。

### 查看部署状态
- Vercel 项目页面 → Deployments
- 绿色 ✅ 表示成功
- 红色 ❌ 表示失败（点击查看详情）

---

## 故障排查

### 问题 1：推送失败
**错误**: `remote: Repository not found`

**解决**:
1. 检查 GitHub 仓库名是否正确
2. 检查远程仓库 URL：`git remote -v`
3. 重新添加：`git remote add origin ...`

### 问题 2：Vercel 部署失败
**错误**: Build failed

**解决**:
1. 检查 `vercel.json` 语法
2. 查看 Vercel 部署日志
3. 确保所有文件都在正确位置

### 问题 3：域名不生效
**解决**:
1. 检查 DNS 配置是否正确
2. 等待 DNS 生效（可能需 48 小时）
3. 清除浏览器缓存

---

## 费用说明

### Vercel 免费计划
- ✅ 无限次部署
- ✅ 100GB 流量/月
- ✅ 自动 HTTPS
- ✅ 自定义域名（免费绑定）
- ✅ CDN 加速

**个人项目完全够用**

### 域名费用
- `.help` 域名：约 $10-15/年（约 ¥70-100）
- 首年可能有优惠

---

## 完成检查清单

- [ ] GitHub 仓库创建成功
- [ ] 代码推送成功
- [ ] Vercel 部署成功
- [ ] 测试所有页面正常
- [ ] 域名实名认证完成
- [ ] DNS 配置完成
- [ ] 域名访问正常
- [ ] 设置自动部署（推送后自动更新）

---

## 需要帮助？

- Vercel 文档：[vercel.com/docs](https://vercel.com/docs)
- GitHub 文档：[docs.github.com](https://docs.github.com)
- 本项目文档：`DEPLOY-CHECKLIST.md`

---

**祝你部署顺利！** 🎉
