# 🦞 龙虾 AI 打工人 - 一键部署网站

龙虾 AI 的官方部署网站，提供一键部署工具和智能咨询。

## 网站结构

```
site/
├── index.html              # 首页
├── deploy.html             # 一键部署（核心功能）
├── pricing.html            # 价格说明
├── api-key-guide.html      # API Key 获取教程
├── windows-wsl-guide.html  # Windows 安装指南
├── onboarding-guide.html   # 新手入门路线图
├── wizard.html             # 部署向导（旧版）
├── faq.html                # 常见问题
├── styles.css              # 全局样式
├── vercel.json             # Vercel 部署配置
└── scripts/
    ├── install-lobster-cn.sh   # 部署脚本
    ├── 一键部署.bat            # Windows 启动器
    ├── 一键部署.command        # macOS 启动器
    └── 一键部署.sh             # Linux 启动器
```

## 部署到 Vercel

### 方式 1：Vercel 控制台（推荐）

1. 访问 [vercel.com](https://vercel.com)
2. 登录 GitHub 账号
3. 点击 "Add New Project"
4. 导入这个仓库
5. 点击 "Deploy"

### 方式 2：Vercel CLI

```bash
# 安装 Vercel CLI
npm i -g vercel

# 登录
vercel login

# 部署
cd site
vercel --prod
```

### 绑定自定义域名

1. 在 Vercel 项目设置 → Domains
2. 添加域名（如 `aiworker.help`）
3. 在域名注册商配置 DNS：
   - `A` 记录 `@` → `76.76.21.21`
   - `CNAME` 记录 `www` → `cname.vercel.com`

## 本地开发

```bash
cd site
python3 -m http.server 8080
# 访问 http://localhost:8080
```

## 功能说明

### 一键部署（deploy.html）

用户流程：
1. 选择系统（Windows/macOS/Linux）
2. 填写 API Key 和模型配置
3. 下载启动器（.bat/.command/.sh）
4. 双击运行，自动完成部署

启动器功能：
- 自动检查环境（WSL、网络等）
- 自动安装依赖
- 执行部署脚本
- 显示完成提示

### 智能咨询（TODO）

计划实现网站聊天机器人，自动回答用户问题。

## 套餐说明

- **免费版**：智能咨询，自动回复
- **¥99 套餐**：一键部署工具

## 技术栈

- 纯 HTML/CSS/JavaScript（静态网站）
- Cloudflare Tunnel（临时托管）
- Vercel（永久托管）

## License

MIT
