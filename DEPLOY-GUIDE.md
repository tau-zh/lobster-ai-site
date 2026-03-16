# 🦞 龙虾 AI 部署完整指南

本指南详细说明从填写配置到完成部署的每一步骤。

---

## 📋 部署流程总览

```
1. 填写配置 → 2. 完成支付 → 3. 下载脚本 → 4. 双击运行 → ✅ 完成
```

预计耗时：**2-5 分钟**（取决于网络速度和电脑配置）

---

## 第一步：填写配置

访问 https://aiworker.help/deploy.html 填写以下信息：

### 1. 选择电脑系统
- **Windows**：Win10 版本 2004+ 或 Win11
- **macOS**：macOS 10.15+（支持 M1/M2/M3）
- **Linux**：Ubuntu 20.04+ / Debian 11+ / Fedora 36+

> 💡 不确定系统版本？查看 [系统要求](./SYSTEM-REQUIREMENTS.md)

### 2. 选择大模型平台
推荐新手选择 **阿里云百炼（通义千问）**：
- 国内访问速度快
- 中文理解能力强
- 有免费额度
- 文档完善

其他可选平台：
- MiniMax（海螺 AI）- 创意写作强
- DeepSeek（深度求索）- 代码能力强
- 智谱 AI - 综合能力强
- 火山方舟（字节）- 性价比高

### 3. 输入 API Key
- 格式通常为 `sk-xxxxxxxx`
- 还没有 API Key？查看 [获取教程](./api-key-guide.html)

### 4. 选择社交软件（可选）
- **飞书** 🚀 - 接入最简单，推荐
- **QQ** 🐧 - 需要额外配置 go-cqhttp
- **微信** 💬 - 推荐企业微信

> 💡 可以稍后再配置社交软件，先部署再配置也可以

---

## 第二步：完成支付

### 支付方式
- 微信支付
- 支付宝

### 支付金额
**¥99**（一次性费用）

### 支付后
1. 等待支付确认（通常 1-2 分钟）
2. 点击"已完成支付"按钮
3. 进入下载页面

---

## 第三步：下载脚本

### Windows 用户
- 下载文件：`lobster-launcher.ps1`
- 文件大小：约 3-5 KB

### macOS 用户
- 下载文件：`lobster-launcher.command`
- 文件大小：约 2-3 KB

### Linux 用户
- 下载文件：`lobster-launcher.sh`
- 文件大小：约 2-3 KB

### 找不到下载文件？
- **Windows**：按 `Ctrl+J` 查看下载记录
- **macOS**：按 `Cmd+Shift+J` 或打开 Safari 下载列表
- 检查浏览器默认的"下载"文件夹

---

## 第四步：运行脚本

### Windows

#### 方法 1：右键运行（推荐）
1. 找到下载的 `lobster-launcher.ps1` 文件
2. **右键点击**文件
3. 选择 **"使用 PowerShell 运行"**
4. 等待部署完成

#### 方法 2：手动运行
1. 右键点击开始菜单，选择 **"Windows PowerShell"** 或 **"终端"**
2. 输入以下命令（替换为实际文件路径）：
   ```powershell
   & "C:\Users\你的用户名\Downloads\lobster-launcher.ps1"
   ```
3. 按回车执行

#### 可能遇到的提示
- **WSL 安装提示**：脚本会自动安装 WSL，完成后需重启电脑
- **执行策略提示**：按提示输入 `Y` 或 `A` 确认

### macOS

#### 首次运行（重要！）
macOS 的安全机制需要额外步骤：

1. 找到下载的 `lobster-launcher.command` 文件
2. **右键点击**（或 Control+ 点击）文件
3. 选择 **"打开"**
4. 点击 **"仍要打开"**
5. 脚本开始运行

> 💡 只需第一次这样操作，以后双击即可运行

#### 正常运行
- 双击 `lobster-launcher.command` 文件
- 终端窗口打开，自动执行部署

#### 可能遇到的提示
- **密码提示**：可能需要输入电脑密码（用于安装依赖）
- **Xcode 提示**：如未安装 Xcode，按提示安装 Command Line Tools

### Linux

#### 方法 1：双击运行
1. 找到 `lobster-launcher.sh` 文件
2. 右键点击 → 属性 → 权限
3. 勾选 **"允许作为程序执行文件"**
4. 双击运行

#### 方法 2：终端运行
```bash
cd ~/下载
chmod +x lobster-launcher.sh
./lobster-launcher.sh
```

---

## 部署过程

脚本会自动完成以下步骤：

### [1/4] 检查系统环境
- 检测操作系统版本
- 检查网络连接
- 验证系统兼容性

### [2/4] 安装依赖
- Git（代码管理工具）
- Node.js 20.x（运行环境）
- pnpm（包管理器）

> ⏱️ 此步骤约 1-3 分钟，取决于网络速度

### [3/4] 下载并配置
- 克隆龙虾 AI 代码仓库
- 安装项目依赖
- 写入你的 API 配置

### [4/4] 启动服务
- 启动龙虾 AI 服务
- 验证服务运行正常
- 显示访问地址

---

## ✅ 部署完成

### 访问龙虾 AI
打开浏览器，访问：**http://localhost:18789**

### 验证是否成功
- 看到龙虾 AI 的 Web 界面
- 可以尝试发送一条消息测试

### 配置文件位置
- **Linux/macOS**：`~/lobster-ai/.env`
- **Windows (WSL)**：`\\wsl$\Ubuntu\home\你的用户名\lobster-ai\.env`

---

## 🔧 配置社交软件（可选）

如部署时选择了社交软件集成：

### 1. 找到配置文件
配置文件位于：`~/lobster-ai/config/social/`

### 2. 飞书配置
编辑 `feishu.json`：
```json
{
  "enabled": true,
  "type": "feishu",
  "name": "飞书",
  "config": {
    "app_id": "cli_xxxxxxxxxxxxx",
    "app_secret": "xxxxxxxxxxxxx",
    "verification_token": "xxxxxxxxxxxxx"
  }
}
```

### 3. 获取飞书配置
1. 访问 https://open.feishu.cn/
2. 登录飞书账号
3. 创建企业自建应用
4. 获取 App ID、App Secret、Verification Token
5. 填入配置文件

### 4. 重启服务
```bash
cd ~/lobster-ai
pkill -f lobster
pnpm start
```

### 5. 测试
- 在飞书中找到你的机器人
- 发送一条消息测试

---

## 🛠️ 常用命令

### 查看日志
```bash
tail -f ~/lobster-ai/lobster.log
```

### 停止服务
```bash
pkill -f lobster
# 或
pkill -f openclaw
```

### 重启服务
```bash
cd ~/lobster-ai
pnpm start
```

### 更新代码
```bash
cd ~/lobster-ai
git pull
pnpm install
pnpm start
```

---

## ❓ 常见问题

### Q: 脚本运行后没反应？
A: 
- Windows：检查是否以 PowerShell 运行
- macOS：检查是否已授权"仍要打开"
- 查看终端/窗口是否有错误提示

### Q: 提示"网络连接失败"？
A:
- 检查网络是否通畅
- 确认可以访问 github.com
- 如使用公司网络，可能需要切换网络

### Q: WSL 安装失败？
A:
- Windows 版本需要 2004 或更高
- 运行 `winver` 检查版本
- 版本过低需升级 Windows

### Q: macOS 提示"无法验证开发者"？
A:
- 这是 macOS 安全机制
- 右键 → 打开 → 仍要打开
- 只需第一次操作

### Q: 端口 18789 被占用？
A:
- 脚本会自动尝试停止旧进程
- 或手动查找并停止：`lsof -ti :18789 | xargs kill -9`

### Q: 部署后找不到 Web 界面？
A:
- 确认服务正在运行
- 检查浏览器地址：http://localhost:18789
- 查看日志：`tail -f ~/lobster-ai/lobster.log`

---

## 📞 获取帮助

- 智能咨询：https://aiworker.help
- FAQ：https://aiworker.help/faq.html
- GitHub：https://github.com/openclaw/openclaw

---

**最后更新**：2026-03-17
