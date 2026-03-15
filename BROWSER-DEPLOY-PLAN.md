# 🦞 纯浏览器部署方案

## 目标
用户**完全不需要下载任何文件**，所有操作在浏览器中完成。

---

## 方案对比

### 方案 A：WebSocket 本地助手（推荐⭐⭐⭐⭐⭐）

**用户体验：**
1. 网页填写配置
2. 点击"开始部署"
3. 网页提示："正在连接本地助手..."
4. 自动检测并启动本地服务
5. 网页显示实时进度
6. 完成！

**技术实现：**
- 用户首次访问时，引导安装一个**本地小助手**（轻量级应用）
- 小助手监听本地端口（如 18790）
- 网页通过 WebSocket/HTTP 与小助手通信
- 小助手执行部署脚本

**优点：**
- ✅ 无需下载压缩包
- ✅ 实时进度显示
- ✅ 更好的错误处理
- ✅ 可以检测部署状态

**缺点：**
- ⚠️ 需要用户先安装小助手
- ⚠️ 开发成本稍高

---

### 方案 B：浏览器 + 一行命令（折中⭐⭐⭐⭐）

**用户体验：**
1. 网页填写配置
2. 点击"生成一键命令"
3. 网页显示一条超短命令
4. 用户复制，终端执行
5. 网页显示实时进度（通过轮询）

**技术实现：**
- 网页生成配置并保存到本地存储
- 命令只负责触发部署脚本
- 部署脚本定期向网页发送状态

**优点：**
- ✅ 命令极短（一行）
- ✅ 网页可显示进度

**缺点：**
- ⚠️ 还是要碰命令行

---

### 方案 C：PWA + Service Worker（技术限制⭐⭐）

**想法：** 用 PWA 的离线能力 + Service Worker
**问题：** Service Worker 无法执行系统命令
**结论：** 不可行

---

### 方案 D：浏览器扩展（复杂⭐⭐）

**想法：** 开发 Chrome 扩展，扩展有权限执行命令
**问题：** 
- 需要用户安装扩展
- 扩展权限受限
- 审核流程
**结论：** 不推荐

---

## 推荐方案：方案 A 的简化版

### 核心思路

**两步走：**

#### 第一步：首次使用（需要下载一次）
1. 用户访问网页
2. 点击"安装本地助手"
3. 下载一个小应用（.app / .exe）
4. 双击安装（只需一次）
5. 助手在后台运行

#### 第二步：部署龙虾（无需下载）
1. 网页填写配置
2. 点击"开始部署"
3. 网页通信本地助手
4. 助手执行部署
5. 网页显示进度

---

## 简化实现：本地助手 MVP

### 助手功能
- 监听本地 HTTP 端口（如 18790）
- 接收部署请求
- 执行部署脚本
- 返回进度和日志

### 技术栈
**选项 A：Python + Flask（推荐）**
```python
from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/deploy', methods=['POST'])
def deploy():
    config = request.json
    # 执行部署脚本
    result = subprocess.run(
        ['bash', 'install-lobster-cn.sh', ...],
        capture_output=True,
        text=True
    )
    return jsonify({'status': 'success', 'log': result.stdout})

if __name__ == '__main__':
    app.run(port=18790)
```

**选项 B：Node.js + Express**
```javascript
const express = require('express');
const { exec } = require('child_process');
const app = express();

app.post('/deploy', (req, res) => {
    exec('bash install-lobster-cn.sh ...', (error, stdout) => {
        res.json({ status: 'success', log: stdout });
    });
});

app.listen(18790);
```

**选项 C：Go（编译成单文件）**
```go
package main

import (
    "net/http"
    "os/exec"
)

func deploy(w http.ResponseWriter, r *http.Request) {
    cmd := exec.Command("bash", "install-lobster-cn.sh", "...")
    output, _ := cmd.CombinedOutput()
    w.Write(output)
}

func main() {
    http.HandleFunc("/deploy", deploy)
    http.ListenAndServe(":18790", nil)
}
```

---

## 最小可行方案：Python 助手

### 为什么选 Python
- ✅ 跨平台（macOS/Windows/Linux）
- ✅ 代码简单
- ✅ 容易打包（PyInstaller）

### 助手代码（lobster-helper.py）
```python
#!/usr/bin/env python3
from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess
import threading
import json

app = Flask(__name__)
CORS(app)  # 允许网页跨域访问

deploy_log = []
deploy_status = "idle"  # idle, running, success, error

@app.route('/status')
def status():
    return jsonify({
        'status': deploy_status,
        'log': deploy_log
    })

@app.route('/deploy', methods=['POST'])
def deploy():
    global deploy_status, deploy_log
    config = request.json
    
    deploy_status = "running"
    deploy_log = ["开始部署...", f"配置：{json.dumps(config, ensure_ascii=False)}"]
    
    def run_deploy():
        global deploy_status
        try:
            # 构建命令
            cmd = [
                'curl', '-fsSL',
                'https://raw.githubusercontent.com/openclaw/openclaw/main/site/scripts/install-lobster-cn.sh',
                '|', 'bash', '-s', '--',
                '--api-key', config['api_key'],
                '--base-url', config['base_url'],
                '--model', config['model']
            ]
            
            # 执行
            result = subprocess.run(
                ' '.join(cmd),
                shell=True,
                capture_output=True,
                text=True
            )
            
            deploy_log.append(result.stdout)
            if result.returncode == 0:
                deploy_status = "success"
                deploy_log.append("✅ 部署完成！")
            else:
                deploy_status = "error"
                deploy_log.append(f"❌ 部署失败：{result.stderr}")
        except Exception as e:
            deploy_status = "error"
            deploy_log.append(f"❌ 错误：{str(e)}")
    
    threading.Thread(target=run_deploy).start()
    return jsonify({'status': 'started'})

if __name__ == '__main__':
    print("🦞 龙虾本地助手已启动")
    print("监听端口：http://localhost:18790")
    app.run(port=18790, debug=False)
```

---

## 网页端改造

### deploy.html 改造

```html
<!-- 检测本地助手 -->
<script>
async function checkHelper() {
    try {
        const res = await fetch('http://localhost:18790/status');
        if (res.ok) {
            return true; // 助手已运行
        }
    } catch {
        return false; // 助手未运行
    }
}

// 页面加载时检测
const helperRunning = await checkHelper();
if (!helperRunning) {
    // 显示安装提示
    showInstallHelperDialog();
}
</script>
```

---

## 实施步骤

### 阶段 1：Python 助手（1 天）
1. 编写助手代码
2. 测试本地通信
3. 部署到网站

### 阶段 2：打包助手（2-3 天）
1. 用 PyInstaller 打包成单文件
2. 创建安装包（.dmg / .exe）
3. 添加代码签名（可选）

### 阶段 3：网页改造（1 天）
1. 添加助手检测
2. 添加安装引导
3. 添加进度显示

---

## 用户流程（完整版）

### 首次使用
1. 访问 `https://aiworker.help`
2. 点击"开始部署"
3. 网页检测：本地助手未安装
4. 显示引导："下载并安装本地助手（只需一次）"
5. 下载 `LobsterHelper.app` / `LobsterHelper.exe`
6. 双击安装
7. 助手在后台运行
8. 网页自动检测到助手

### 部署龙虾
1. 网页填写配置（API Key 等）
2. 点击"开始部署"
3. 网页显示实时进度：
   - ⏳ 正在检查环境...
   - ⏳ 正在安装依赖...
   - ⏳ 正在克隆代码...
   - ✅ 部署完成！
4. 显示访问地址

---

## 成本估算

| 项目 | 时间 | 难度 |
|------|------|------|
| Python 助手原型 | 1 天 | ⭐⭐ |
| PyInstaller 打包 | 1 天 | ⭐⭐⭐ |
| 安装包制作 | 1-2 天 | ⭐⭐⭐ |
| 网页改造 | 1 天 | ⭐⭐ |
| 代码签名（可选） | 半天 | ⭐⭐⭐⭐ |
| **总计** | **4-5 天** | |

---

## 下一步

**确认是否采用此方案？**

如果采用，我可以立即开始：
1. 编写 Python 助手代码
2. 测试本地通信
3. 修改网页添加助手检测

或者，如果你觉得安装助手还是太麻烦，我们可以继续优化**方案 C（下载 zip）**，让它更简单。

你怎么看？
