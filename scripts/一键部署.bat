@echo off
chcp 65001 >nul
title 龙虾 AI 一键部署工具

echo.
echo ========================================
echo   🦞 龙虾 AI 一键部署工具
echo ========================================
echo.
echo 正在检查系统环境...
echo.

:: 检查是否安装了 WSL
wsl --list >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 未检测到 WSL
    echo.
    echo 正在安装 WSL，请稍候...
    echo.
    wsl --install
    echo.
    echo [重要] WSL 安装完成后需要重启电脑！
    echo 重启后请重新运行此部署工具。
    echo.
    pause
    exit /b 1
)

echo [✓] WSL 已安装
echo.

:: 检查网络连接
echo 正在检查网络连接...
ping -n 1 -w 1000 raw.githubusercontent.com >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 网络连接可能不稳定
    echo 如果部署失败，请检查网络后重试
    echo.
)

:: 读取配置
echo 正在读取配置...
if not exist "config.json" (
    echo [错误] 未找到配置文件 config.json
    echo 请确保此文件与部署工具在同一目录
    pause
    exit /b 1
)

:: 解析配置（简单提取）
for /f "tokens=2 delims=:," %%a in ('findstr "api_key" config.json') do set API_KEY=%%~a
for /f "tokens=2 delims=:," %%a in ('findstr "base_url" config.json') do set BASE_URL=%%~a
for /f "tokens=2 delims=:," %%a in ('findstr "model" config.json') do set MODEL=%%~a
for /f "tokens=2 delims=:," %%a in ('findstr "social" config.json') do set SOCIAL=%%~a

:: 去除引号和空格
set API_KEY=%API_KEY:"=%
set API_KEY=%API_KEY: =%
set BASE_URL=%BASE_URL:"=%
set BASE_URL=%BASE_URL: =%
set MODEL=%MODEL:"=%
set MODEL=%MODEL: =%
set SOCIAL=%SOCIAL:"=%
set SOCIAL=%SOCIAL: =%

echo [✓] 配置读取成功
echo     API Key: %API_KEY:~0,6%...%API_KEY:~-4%
echo     模型：%MODEL%
echo.

:: 执行部署
echo ========================================
echo   开始部署
echo ========================================
echo.
echo 这可能需要 2-5 分钟，请稍候...
echo.

wsl bash -c "curl -fsSL 'https://raw.githubusercontent.com/openclaw/openclaw/main/site/scripts/install-lobster-cn.sh' | bash -s -- --api-key '%API_KEY%' --base-url '%BASE_URL%' --model '%MODEL%' --social '%SOCIAL%'"

if %errorlevel% neq 0 (
    echo.
    echo [错误] 部署失败
    echo 请查看错误信息，或联系支持
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✅ 部署完成！
echo ========================================
echo.
echo 📍 访问地址：http://localhost:18789
echo.
echo 📁 安装目录：~/lobster-ai
echo 📄 配置文件：~/lobster-ai/.env
echo.
echo 如配置了社交软件，配置文件位于：
echo   ~/lobster-ai/config/social/
echo.
echo 按任意键退出...
pause >nul
