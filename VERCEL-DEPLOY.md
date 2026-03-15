# 🚀 部署到 Vercel + 自定义域名指南

## 为什么选择 Vercel

- ✅ **完全免费** - 个人项目免费额度足够用
- ✅ **自动 HTTPS** - 无需配置 SSL 证书
- ✅ **自定义域名** - 可以绑定自己的域名（如 niumaAI.com）
- ✅ **全球 CDN** - 访问速度快
- ✅ **自动部署** - 推送代码自动更新
- ✅ **稳定可靠** - 不需要手动重启

---

## 步骤 1：准备域名

### 方案 A：已有域名
如果你已经有域名（比如 `niumaAI.com`），直接跳到步骤 2。

### 方案 B：购买新域名
推荐平台：
- **Namesilo** - 便宜，约 $10/年
- **Namecheap** - 界面友好，约 $10/年
- **阿里云万网** - 国内，约 ¥55/年
- **腾讯云 DNSPod** - 国内，约 ¥55/年

**域名建议：**
- `niumaAI.com` - 如果被注册了，试试：
- `niuma-ai.com`
- `lobster-ai.com`
- `niuma.ai` - .ai 域名较贵，约 $60/年
- `niuma.work`
- `niuma.app`

---

## 步骤 2：部署到 Vercel

### 2.1 创建 GitHub 仓库（如果还没有）

```bash
cd /Users/siwei/.openclaw/workspace/site
git init
git add .
git commit -m "Initial commit: 龙虾 AI 部署网站"
# 然后在 GitHub 创建新仓库，按提示推送
```

### 2.2 在 Vercel 部署

1. **访问 Vercel**
   - 打开 https://vercel.com
   - 用 GitHub 账号登录

2. **导入项目**
   - 点击 "Add New Project"
   - 选择 "Import Git Repository"
   - 选择你的仓库（比如 `lobster-site`）
   - 点击 "Import"

3. **配置项目**
   - **Framework Preset**: Other
   - **Root Directory**: `./site`（如果仓库根目录就是 site，留空）
   - **Build Command**: 留空（或 `echo 'No build needed'`）
   - **Output Directory**: `.`（或留空）
   - **Install Command**: 留空

4. **点击 Deploy**
   - 等待部署完成（约 30 秒）
   - 部署成功后会显示一个 `https://xxx.vercel.app` 的链接

5. **测试访问**
   - 打开 Vercel 给的链接
   - 确认所有页面正常

---

## 步骤 3：绑定自定义域名

### 3.1 在 Vercel 添加域名

1. 进入你的 Vercel 项目
2. 点击 "Settings" → "Domains"
3. 点击 "Add"
4. 输入你的域名，比如 `niumaAI.com`
5. 点击 "Add"

### 3.2 配置 DNS

Vercel 会显示两种配置方式：

#### 方式 A：使用根域名（推荐）

在你的域名注册商处添加：

| 类型 | 名称/主机记录 | 值/记录内容 |
|------|--------------|------------|
| `A` | `@` | `76.76.21.21` |

#### 方式 B：使用 www 子域名

在你的域名注册商处添加：

| 类型 | 名称/主机记录 | 值/记录内容 |
|------|--------------|------------|
| `CNAME` | `www` | `cname.vercel.com` |

**建议两种都配置**，这样用户访问 `niumaAI.com` 和 `www.niumaAI.com` 都可以。

### 3.3 等待 DNS 生效

- 通常 5-30 分钟生效
- 最长可能需要 48 小时
- 可以用这个工具检查：https://dnschecker.org/

### 3.4 配置 HTTPS

Vercel 会**自动**为你的域名配置 HTTPS 证书，无需手动操作。

等待 DNS 生效后，Vercel 会自动：
- 申请 SSL 证书
- 配置自动续期
- 强制 HTTPS 跳转

---

## 步骤 4：更新网站中的链接

部署到 Vercel 后，需要更新 `wizard.html` 中的脚本地址。

### 4.1 上传部署脚本

把 `site/scripts/install-lobster-cn.sh` 上传到你的 GitHub 仓库。

### 4.2 获取 Raw 链接

在 GitHub 仓库中，打开脚本文件，点击 "Raw" 按钮，复制链接。

格式应该是：
```
https://raw.githubusercontent.com/你的用户名/你的仓库/main/scripts/install-lobster-cn.sh
```

### 4.3 更新 wizard.html

编辑 `site/wizard.html`，找到 `generateCommand()` 函数，修改：

```javascript
const scriptUrl = 'https://raw.githubusercontent.com/你的用户名/你的仓库/main/scripts/install-lobster-cn.sh';
```

### 4.4 推送更新

```bash
cd /Users/siwei/.openclaw/workspace/site
git add .
git commit -m "Update script URL for production"
git push
```

Vercel 会自动检测推送并重新部署。

---

## 费用说明

### Vercel 免费额度

- ✅ **无限次部署**
- ✅ **100GB 流量/月**（足够个人项目）
- ✅ **自动 HTTPS**
- ✅ **自定义域名**（免费绑定）
- ✅ **CDN 加速**

### 域名费用

- `.com` - 约 $10-15/年（约 ¥70-100/年）
- `.ai` - 约 $60-80/年（约 ¥400-550/年）
- `.app` - 约 $15-20/年（约 ¥100-140/年）
- `.work` - 约 $2-5/年（首年优惠）

### 总计

**首年成本：约 ¥100-150**（域名 + 免费 Vercel）

---

## 常见问题

### Q: Vercel 部署后访问慢？
A: Vercel 在全球有 CDN，但如果你的用户主要在中国大陆，可以考虑：
- 使用 Cloudflare CDN（免费）
- 或者选择国内服务器（需要备案）

### Q: 域名备案问题？
A: 
- 使用 Vercel 的海外服务器**不需要备案**
- 但如果要使用国内服务器，必须备案
- 不备案也可以正常使用，只是国内访问速度可能稍慢

### Q: 流量超了怎么办？
A: Vercel 免费额度是 100GB/月，个人项目很难用完。如果真超了：
- 升级 Pro 计划：$20/月
- 或者优化网站（压缩图片、启用缓存）

### Q: 如何查看访问统计？
A: Vercel 提供基础分析：
- 项目页面 → "Analytics"
- 或用第三方工具：Google Analytics、Umami 等

### Q: 域名到期了怎么办？
A: 
- 域名注册商会邮件提醒你续费
- 及时续费即可，通常有 30 天宽限期
- 建议开启自动续费

---

## 快速检查清单

- [ ] 购买域名（如 `niumaAI.com`）
- [ ] 创建 GitHub 仓库
- [ ] 推送网站代码到 GitHub
- [ ] 在 Vercel 部署项目
- [ ] 在 Vercel 绑定自定义域名
- [ ] 在域名注册商配置 DNS
- [ ] 等待 DNS 生效（5-30 分钟）
- [ ] 测试访问 `https://niumaAI.com`
- [ ] 更新 `wizard.html` 中的脚本地址
- [ ] 推送更新到 GitHub

---

## 需要帮助？

如果遇到问题：
1. 查看 Vercel 文档：https://vercel.com/docs
2. 检查 DNS 配置：https://dnschecker.org/
3. 咨询：小红书 ID `6238327607`

---

## 下一步

部署完成后：
1. 测试完整部署流程
2. 录制视频教程
3. 开始推广

祝部署顺利！🎉
