🦞 龙虾 AI 一键部署工具
========================

使用方法（超简单！）
--------------------

【Windows 用户】
1. 双击运行 "一键部署.bat"
2. 等待部署完成（2-5 分钟）
3. 打开浏览器访问：http://localhost:18789

【macOS 用户】
1. 双击运行 "一键部署.command"
2. 如果提示"无法打开"，请：
   - 右键点击此文件
   - 选择"打开"
   - 点击"仍要打开"
3. 等待部署完成（2-5 分钟）
4. 打开浏览器访问：http://localhost:18789

【Linux 用户】
1. 打开终端
2. 运行：bash 一键部署.sh
3. 等待部署完成（2-5 分钟）
4. 打开浏览器访问：http://localhost:18789


部署完成后
------------
✅ 龙虾 AI 会在你的电脑上运行
✅ 浏览器访问 http://localhost:18789 开始使用
✅ 如配置了社交软件，配置文件在 ~/lobster-ai/config/social/


常见问题
--------

Q: Windows 提示"未检测到 WSL"？
A: 部署工具会自动安装 WSL，安装完成后重启电脑，再重新运行部署工具。

Q: macOS 提示"无法打开"？
A: 右键点击文件 → 选择"打开" → 点击"仍要打开"。这是 macOS 的安全机制，第一次需要手动确认。

Q: 部署失败怎么办？
A: 
1. 检查网络连接
2. 查看终端/命令提示符中的错误信息
3. 确保配置文件 config.json 存在且内容正确
4. 访问 https://aiworker.help/faq.html 获取更多帮助

Q: 部署后在哪里找到龙虾 AI？
A: 打开浏览器，访问 http://localhost:18789

Q: 如何停止龙虾 AI？
A: 关闭运行龙虾 AI 的终端窗口，或运行：pkill -f lobster


技术支持
--------
网站：https://aiworker.help
文档：https://github.com/openclaw/openclaw


祝你使用愉快！🎉
