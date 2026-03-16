# 🖥️ 系统要求

龙虾 AI 一键部署工具支持以下操作系统：

## Windows

### 最低要求
- **系统版本**：Windows 10 版本 2004 或更高（Build 19041+）
- **内存**：4GB RAM（推荐 8GB+）
- **存储**：至少 5GB 可用空间
- **网络**：可访问 GitHub 和大模型 API 平台

### 自动安装组件
- WSL 2（Windows Subsystem for Linux）
- Ubuntu 22.04 LTS（通过 WSL）

### 检查你的 Windows 版本
1. 按 `Win + R` 键
2. 输入 `winver` 并按回车
3. 查看版本号（需要 2004 或更高）

### 如果版本过低
- 访问 Windows 更新设置，升级到最新版本
- 或访问微软官网下载最新版 Windows 10/11

---

## macOS

### 最低要求
- **系统版本**：macOS 10.15 (Catalina) 或更高
- **芯片**：Intel 或 Apple Silicon (M1/M2/M3) 均可
- **内存**：4GB RAM（推荐 8GB+）
- **存储**：至少 5GB 可用空间
- **网络**：可访问 GitHub 和大模型 API 平台

### 自动安装组件
- Homebrew（如未安装）
- Node.js 20.x
- Git

### 检查你的 macOS 版本
1. 点击屏幕左上角苹果菜单 
2. 选择"关于本机"
3. 查看 macOS 版本

### 支持的 macOS 版本
- ✅ macOS 14 Sonoma
- ✅ macOS 13 Ventura
- ✅ macOS 12 Monterey
- ✅ macOS 11 Big Sur
- ✅ macOS 10.15 Catalina

---

## Linux

### 支持的发行版
- ✅ Ubuntu 20.04 LTS 或更高
- ✅ Ubuntu 22.04 LTS（推荐）
- ✅ Debian 11 (Bullseye) 或更高
- ✅ Fedora 36 或更高
- ✅ 其他主流发行版（需支持 apt/yum/pacman 包管理器）

### 最低要求
- **内存**：4GB RAM（推荐 8GB+）
- **存储**：至少 5GB 可用空间
- **网络**：可访问 GitHub 和大模型 API 平台
- **权限**：sudo 权限

### 自动安装组件
- Git
- Node.js 20.x
- pnpm

---

## 部署后资源占用

### 正常运行时
- **CPU**：约 5-15%（空闲时更低）
- **内存**：约 300-800MB
- **磁盘**：约 1-2GB（含依赖）

### 处理请求时
- **CPU**：峰值可达 50-100%（短暂）
- **内存**：峰值可达 1-2GB

---

## 社交软件集成要求

### 飞书 (Feishu)
- 飞书企业版账号（免费版即可）
- 可访问飞书开放平台

### QQ
- QQ 账号
- 需额外安装 go-cqhttp（部署脚本会提示）

### 微信
- 推荐使用企业微信（个人微信接入较复杂）
- 企业微信管理员权限

---

## 网络要求

### 需要访问的域名
- `github.com` - 代码仓库
- `raw.githubusercontent.com` - 脚本下载
- 大模型平台 API（根据选择）：
  - `dashscope.aliyuncs.com` - 阿里云百炼
  - `api.deepseek.com` - DeepSeek
  - `api.minimax.chat` - MiniMax
  - `open.bigmodel.cn` - 智谱 AI
  - `ark.cn-beijing.volces.com` - 火山方舟

### 防火墙设置
如使用公司网络或防火墙，请确保上述域名未被屏蔽。

---

## 常见问题

### Q: 我的系统符合要求吗？
A: 如果你的电脑是 2018 年后购买的，基本都符合要求。部署脚本会自动检测并提示。

### Q: 部署失败怎么办？
A: 
1. 检查系统版本是否符合要求
2. 检查网络连接
3. 查看脚本输出的错误信息
4. 访问 https://aiworker.help/faq.html 获取帮助

### Q: 可以在虚拟机或云服务器上部署吗？
A: 可以。只要系统符合要求且能访问必要网络，虚拟机、云服务器均可。

### Q: 多个电脑可以共用一个 API Key 吗？
A: 可以，但注意 API 调用量会计入同一账户，可能产生更高费用。

---

**最后更新**：2026-03-17
