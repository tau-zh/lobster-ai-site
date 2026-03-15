# 🤖 智能咨询机器人自动回复方案

## 目标
用户有任何问题，AI 机器人自动抓取并回复，无需人工干预。

---

## 方案概述

### 用户流程
1. 用户在网站/社交软件中提问
2. 问题自动发送给 AI 机器人
3. AI 分析问题并生成回复
4. 用户收到自动回复

### 技术架构
```
用户提问 → 问题抓取 → AI 分析 → 自动回复
           ↓
      常见问题库
           ↓
      无法回答 → 转人工（可选）
```

---

## 实施方案

### 方案 A：网站内嵌聊天机器人（推荐⭐⭐⭐⭐⭐）

**实现方式：**
- 在网站右下角添加聊天窗口
- 用户直接网页提问
- 调用大模型 API 自动回复

**技术栈：**
- 前端：简单的聊天 UI 组件
- 后端：Node.js/Python 接收问题
- AI：调用阿里云百炼/MiniMax API

**优点：**
- ✅ 用户体验好
- ✅ 无需额外平台
- ✅ 完全可控

**实现步骤：**
1. 创建聊天 UI 组件（HTML/CSS/JS）
2. 后端接收问题并调用 AI API
3. 返回回复并显示

---

### 方案 B：社交软件机器人（推荐⭐⭐⭐⭐）

**实现方式：**
- 在飞书/QQ/微信创建机器人
- 用户私信或群内@机器人
- 机器人自动回复

**技术栈：**
- 飞书：企业自建应用 + 消息回调
- QQ：go-cqhttp + 插件
- 微信：企业微信 + 自建应用

**优点：**
- ✅ 用户习惯
- ✅ 可离线使用
- ✅ 易于传播

---

### 方案 C：邮件自动回复（简单⭐⭐⭐）

**实现方式：**
- 用户发送邮件到指定邮箱
- 自动转发给 AI 处理
- 回复邮件给用户

**技术栈：**
- 邮箱服务（如 Gmail/163）
- 邮件转发规则
- AI 处理脚本

**优点：**
- ✅ 实现简单
- ✅ 成本低

---

## 推荐方案：A + B 组合

### 第一阶段：网站聊天机器人（1-2 天）

**实现步骤：**

#### 1. 创建聊天 UI 组件

```html
<!-- chat-widget.html -->
<div id="chat-widget">
  <div class="chat-button" onclick="toggleChat()">💬</div>
  <div class="chat-window" id="chat-window">
    <div class="chat-header">
      <h4>🤖 龙虾 AI 助手</h4>
      <button onclick="toggleChat()">×</button>
    </div>
    <div class="chat-messages" id="chat-messages">
      <div class="message bot">
        你好！我是龙虾 AI 助手，有什么问题可以问我~
      </div>
    </div>
    <div class="chat-input">
      <input type="text" id="chat-input" placeholder="输入问题..." onkeypress="handleKeyPress(event)">
      <button onclick="sendMessage()">发送</button>
    </div>
  </div>
</div>

<style>
#chat-widget { position: fixed; bottom: 20px; right: 20px; z-index: 9999; }
.chat-button { width: 60px; height: 60px; border-radius: 50%; background: #2563eb; color: white; font-size: 24px; border: none; cursor: pointer; box-shadow: 0 4px 12px rgba(37,99,235,0.3); }
.chat-window { display: none; position: fixed; bottom: 90px; right: 20px; width: 350px; height: 500px; background: white; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.15); flex-direction: column; overflow: hidden; }
.chat-header { background: #2563eb; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
.chat-header h4 { margin: 0; }
.chat-header button { background: none; border: none; color: white; font-size: 24px; cursor: pointer; }
.chat-messages { flex: 1; padding: 1rem; overflow-y: auto; background: #f9fafb; }
.message { margin-bottom: 1rem; padding: 0.75rem 1rem; border-radius: 8px; max-width: 80%; }
.message.bot { background: #e5e7eb; color: #1f2937; }
.message.user { background: #2563eb; color: white; margin-left: auto; }
.chat-input { display: flex; padding: 1rem; border-top: 1px solid #e5e7eb; background: white; }
.chat-input input { flex: 1; padding: 0.5rem 1rem; border: 1px solid #d1d5db; border-radius: 20px; margin-right: 0.5rem; }
.chat-input button { padding: 0.5rem 1.5rem; background: #2563eb; color: white; border: none; border-radius: 20px; cursor: pointer; }
</style>
```

#### 2. JavaScript 逻辑

```javascript
// chat-widget.js
const API_KEY = '你的 API Key';
const API_URL = 'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions';

async function sendMessage() {
  const input = document.getElementById('chat-input');
  const message = input.value.trim();
  if (!message) return;
  
  // 显示用户消息
  addMessage(message, 'user');
  input.value = '';
  
  // 显示"正在输入..."
  addMessage('思考中...', 'bot', true);
  
  try {
    // 调用 AI API
    const response = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${API_KEY}`
      },
      body: JSON.stringify({
        model: 'qwen-plus',
        messages: [
          {
            role: 'system',
            content: `你是龙虾 AI 助手的客服机器人，负责回答用户关于产品、部署、价格等问题。

产品说明：
- 龙虾 AI 是一个本地部署的 AI 助手
- 免费版：智能咨询，自动回复
- ¥99 套餐：一键部署工具，双击完成部署
- 支持 Windows/macOS/Linux
- 需要大模型 API Key（阿里云百炼/MiniMax 等）

回答规则：
1. 友好、简洁、专业
2. 引导用户查看网站文档
3. 无法回答时建议联系人工支持`
          },
          { role: 'user', content: message }
        ]
      })
    });
    
    const data = await response.json();
    const reply = data.choices[0].message.content;
    
    // 移除"正在输入..."，显示真实回复
    removeLastBotMessage();
    addMessage(reply, 'bot');
    
  } catch (error) {
    removeLastBotMessage();
    addMessage('抱歉，我现在有点忙，请稍后再试。', 'bot');
  }
}

function addMessage(text, type, isLoading = false) {
  const messages = document.getElementById('chat-messages');
  const div = document.createElement('div');
  div.className = `message ${type}${isLoading ? ' loading' : ''}`;
  div.textContent = text;
  messages.appendChild(div);
  messages.scrollTop = messages.scrollHeight;
}

function removeLastBotMessage() {
  const messages = document.getElementById('chat-messages');
  const lastBot = messages.querySelector('.message.bot.loading');
  if (lastBot) lastBot.remove();
}

function toggleChat() {
  const window = document.getElementById('chat-window');
  window.style.display = window.style.display === 'flex' ? 'none' : 'flex';
}

function handleKeyPress(event) {
  if (event.key === 'Enter') sendMessage();
}
```

#### 3. 集成到网站

在所有页面的 `<body>` 结束前添加：
```html
<script src="./chat-widget.js"></script>
```

---

### 第二阶段：社交软件机器人（可选）

**飞书机器人示例：**

```python
# feishu-bot.py
from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

API_KEY = '你的 API Key'
API_URL = 'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions'

@app.route('/webhook', methods=['POST'])
def webhook():
    data = request.json
    message = data.get('text', '')
    
    # 调用 AI
    response = requests.post(API_URL, json={
        'model': 'qwen-plus',
        'messages': [
            {'role': 'system', 'content': '你是龙虾 AI 助手客服...'},
            {'role': 'user', 'content': message}
        ]
    }, headers={'Authorization': f'Bearer {API_KEY}'})
    
    reply = response.json()['choices'][0]['message']['content']
    
    return jsonify({'text': reply})

if __name__ == '__main__':
    app.run(port=8080)
```

---

## 常见问题库

预先准备一些常见问题的标准回复：

### 产品相关
- Q: 这是什么产品？
- A: 龙虾 AI 是一个本地部署的 AI 助手...

### 价格相关
- Q: 多少钱？
- A: 免费咨询，¥99 一键部署...

### 部署相关
- Q: 怎么部署？
- A: 下载启动器，双击运行...

### 技术相关
- Q: 支持什么系统？
- A: Windows/macOS/Linux...

---

## 成本估算

| 项目 | 费用 |
|------|------|
| 网站聊天机器人 | 免费（自己开发） |
| AI API 费用 | 约 ¥10-50/月 |
| 飞书机器人 | 免费 |
| QQ 机器人 | 免费 |
| 微信机器人 | 免费（企业微信） |

---

## 下一步

1. **确认采用方案**（网站聊天机器人）
2. **创建聊天 UI 组件**
3. **配置 AI API**
4. **测试并上线**

需要我立即开始实现网站聊天机器人吗？
