# 🦞 龙虾 AI 一键部署方案

## 方案说明

本方案实现用户通过网页填写信息后，在本地电脑一键部署龙虾 AI。

## 用户流程

### 1. 访问部署向导
用户访问：`https://famous-triangle-male-systems.trycloudflare.com/wizard.html`

### 2. 填写信息
- 姓名
- 操作系统（macOS / Windows WSL / Linux）
- 使用场景
- 选择的模型平台（阿里百炼/MiniMax/DeepSeek 等）
- 社交软件集成选项（飞书/QQ/微信）

### 3. 获取 API Key
- 查看图文教程（`api-key-guide.html`）
- 到对应平台获取 API Key
- 返回网页填写 API Key

### 4. 执行部署命令
网页生成个性化部署命令，用户复制后在本地终端执行：

```bash
# macOS / Linux 用户
curl -fsSL <脚本地址> | bash -s -- \
  --api-key "sk-xxx" \
  --base-url "https://..." \
  --model "qwen-max" \
  --social "feishu,qq,wechat"

# Windows WSL 用户
# 先在 WSL 终端中执行相同命令
```

### 5. 自动完成
脚本自动完成：
- ✅ 检查/安装 Git
- ✅ 检查/安装 Node.js
- ✅ 检查/安装 pnpm
- ✅ 克隆 OpenClaw 代码
- ✅ 安装依赖
- ✅ 配置环境变量（API Key 等）
- ✅ 配置社交软件集成（可选）
- ✅ 启动服务

### 6. 使用
部署完成后：
- 浏览器访问 `http://localhost:18789`
- 如配置了社交软件，可在对应软件中对话

## 部署脚本说明

脚本位置：`site/scripts/install-lobster-cn.sh`

### 脚本功能

1. **环境检查**
   - 检测操作系统（macOS/Linux）
   - 检查 Git、Node.js、pnpm 是否安装
   - 自动安装缺失的依赖

2. **代码获取**
   - 克隆 OpenClaw 仓库
   - 或更新已有代码

3. **依赖安装**
   - 使用 pnpm 安装项目依赖

4. **环境配置**
   - 生成 `.env` 文件
   - 填入用户提供的 API Key、Base URL、Model
   - 备份已有配置

5. **社交集成**（可选）
   - 创建飞书/QQ/微信配置文件模板
   - 用户需后续填写具体凭证

6. **服务启动**
   - 后台启动龙虾 AI 服务
   - 监听 18789 端口

### 脚本参数

| 参数 | 必填 | 说明 |
|------|------|------|
| `--api-key` | 是 | 大模型 API Key |
| `--base-url` | 是 | API Base URL |
| `--model` | 是 | 模型名称 |
| `--social` | 否 | 社交软件（逗号分隔：feishu,qq,wechat） |
| `--install-dir` | 否 | 安装目录（默认：$HOME/lobster-ai） |

### 脚本托管

脚本需要托管到可公开访问的 URL，推荐方案：

1. **GitHub Raw**（推荐）
   ```
   https://raw.githubusercontent.com/你的用户名/你的仓库/main/site/scripts/install-lobster-cn.sh
   ```

2. **Gitee Raw**（国内访问更快）
   ```
   https://gitee.com/你的用户名/你的仓库/raw/main/site/scripts/install-lobster-cn.sh
   ```

3. **自己的服务器**
   ```
   https://你的域名/scripts/install-lobster-cn.sh
   ```

## 网页部署

### 更新 wizard.html 中的脚本地址

编辑 `site/wizard.html`，找到 `generateCommand()` 函数，修改 `scriptUrl`：

```javascript
const scriptUrl = 'https://raw.githubusercontent.com/你的用户名/你的仓库/main/site/scripts/install-lobster-cn.sh';
```

### 部署网站

网站已通过 Cloudflare Tunnel 上线：
```
https://famous-triangle-male-systems.trycloudflare.com
```

如需长期运行，建议：
1. 购买域名
2. 配置 Cloudflare Tunnel 固定域名
3. 或使用其他静态网站托管（Vercel/Netlify/GitHub Pages）

## 社交软件集成说明

### 飞书
需要创建飞书应用，获取：
- App ID
- App Secret
- Verification Token

配置后，龙虾 AI 可以作为飞书机器人使用。

### QQ
需要使用 QQ 机器人框架（如 go-cqhttp），配置：
- 机器人 QQ 号
- Token/密码

### 微信
需要使用微信机器人框架（如 wechaty），配置：
- 微信账号（扫码登录）
- 或企业微信应用配置

**注意：** 社交软件集成需要额外配置，一键部署只创建配置文件模板，用户需根据实际平台要求填写。

## 故障排查

### 脚本执行失败

1. **网络问题**
   ```bash
   # 检查网络连接
   ping github.com
   
   # 如无法访问，尝试使用 Gitee 镜像
   ```

2. **权限问题**
   ```bash
   # 手动下载脚本
   curl -fsSL <脚本地址> -o install.sh
   chmod +x install.sh
   ./install.sh --api-key "..." --base-url "..." --model "..."
   ```

3. **依赖安装失败**
   ```bash
   # 手动安装 Node.js
   # macOS: brew install node
   # Ubuntu: curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt install -y nodejs
   
   # 手动安装 pnpm
   npm install -g pnpm
   ```

### 服务启动失败

1. **查看日志**
   ```bash
   tail -f ~/lobster-ai/lobster.log
   ```

2. **检查端口占用**
   ```bash
   lsof -i :18789
   # 或
   netstat -tlnp | grep 18789
   ```

3. **检查配置**
   ```bash
   cat ~/lobster-ai/.env
   ```

## 下一步优化

1. **脚本托管** - 将脚本上传到 GitHub/Gitee
2. **版本管理** - 脚本添加版本控制和更新机制
3. **配置验证** - 部署前验证 API Key 有效性
4. **进度显示** - 脚本执行时显示更详细的进度
5. **错误恢复** - 更好的错误处理和恢复机制
6. **视频教程** - 录制部署过程视频

## 联系方式

- 咨询：小红书 ID `6238327607`
- 项目：https://github.com/openclaw/openclaw
