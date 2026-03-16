# 网站上线状态

## 当前公开访问地址
- **正式域名**：https://aiworker.help
- **Vercel 预览**：https://site-5fhn3a7oi-zhengtaowd-2805s-projects.vercel.app

## 当前版本
- ✅ 静态销售站已上线
- ✅ 首页 / 套餐页 / 部署页 / FAQ 已完成
- ✅ 部署流程优化：填写配置 → 完成支付 → 下载脚本 → 双击运行
- ✅ 面向小白用户简化文案
- ✅ 支持 Windows/macOS/Linux 全平台
- ✅ 完整部署指南文档
- ✅ 系统要求文档

## 系统支持

### Windows
- ✅ Windows 10 版本 2004+ (Build 19041+)
- ✅ Windows 11
- ✅ 自动安装 WSL 2
- ✅ PowerShell 脚本一键部署

### macOS
- ✅ macOS 10.15 Catalina+
- ✅ macOS 11 Big Sur
- ✅ macOS 12 Monterey
- ✅ macOS 13 Ventura
- ✅ macOS 14 Sonoma
- ✅ Intel 和 Apple Silicon (M1/M2/M3)
- ✅ 自动安装 Xcode CLI / Homebrew

### Linux
- ✅ Ubuntu 20.04 LTS+
- ✅ Ubuntu 22.04 LTS（推荐）
- ✅ Debian 11+
- ✅ Fedora 36+
- ✅ 自动检测发行版并安装依赖

## 部署流程（用户视角）

1. **填写配置** - 选择电脑系统、大模型平台、输入 API Key、选择社交软件
2. **完成支付** - 支付 ¥99 部署套餐费用
3. **下载脚本** - 支付成功后下载专属部署脚本（几 KB）
4. **双击运行** - 运行脚本自动完成部署，2-5 分钟即可使用

## 部署脚本功能

### 自动检测
- ✅ 系统类型和版本
- ✅ 网络连接状态
- ✅ 已安装的依赖

### 自动安装
- ✅ Git
- ✅ Node.js 20.x
- ✅ pnpm
- ✅ WSL 2（Windows）
- ✅ Xcode CLI（macOS）

### 配置
- ✅ 克隆代码仓库
- ✅ 安装项目依赖
- ✅ 写入 API 配置
- ✅ 生成社交软件配置模板

### 启动
- ✅ 启动服务
- ✅ 验证端口
- ✅ 显示访问地址

## 文档

| 文档 | 说明 | 链接 |
|------|------|------|
| 部署指南 | 完整部署步骤说明 | /DEPLOY-GUIDE.md |
| 系统要求 | 支持的系统和版本 | /SYSTEM-REQUIREMENTS.md |
| API Key 教程 | 获取大模型 API Key | /api-key-guide.html |
| FAQ | 常见问题解答 | /faq.html |
| 价格说明 | 套餐和费用说明 | /pricing.html |

## 社交软件集成

### 飞书
- ✅ 配置模板自动生成
- ✅ 详细配置说明
- ✅ 推荐新手使用

### QQ
- ✅ 配置模板自动生成
- ✅ 需额外安装 go-cqhttp

### 微信
- ✅ 配置模板自动生成
- ✅ 推荐企业微信

## 当前定位
- MVP 版本已上线
- 一键部署 + 智能咨询
- 先收单、先成交、先拿案例

## 后续升级方向
1. **支付集成** - 微信/支付宝二维码自动生成
2. **支付确认** - 自动确认支付并显示下载链接
3. **表单后端** - 收集用户配置信息
4. **部署状态追踪** - 实时显示部署进度
5. **智能咨询机器人** - 接入网站自动回复
6. **SSH 半自动部署** - 远程协助部署

## 域名配置
- 主域名：aiworker.help
- DNS 已配置：
  - A 记录 `@` → `76.76.21.21`
  - CNAME 记录 `www` → `cname.vercel-dns.com`

## 最后更新
2026-03-17 00:30 GMT+1
