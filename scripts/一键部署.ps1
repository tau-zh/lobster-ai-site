# 🦞 龙虾 AI 一键部署工具 (PowerShell)
# 使用方法：右键 → 使用 PowerShell 运行

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  龙虾 AI 一键部署工具" -ForegroundColor Cyan
Write-Host "  套餐：标准版 (¥99)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 设置编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 检查配置文件
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$configPath = Join-Path $scriptDir "config.json"

if (-not (Test-Path $configPath)) {
    Write-Host "[错误] 未找到配置文件 config.json" -ForegroundColor Red
    Write-Host "请确保此文件与部署工具在同一目录" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "[✓] 配置文件找到" -ForegroundColor Green
Write-Host ""

# 读取配置
try {
    $config = Get-Content $configPath -Raw | ConvertFrom-Json
    $apiKey = $config.api_key
    $baseUrl = $config.base_url
    $model = $config.model
    $social = $config.social
} catch {
    Write-Host "[错误] 配置文件格式错误" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "[✓] 配置读取成功" -ForegroundColor Green
Write-Host "    API Key: $($apiKey.Substring(0,6))...$($apiKey.Substring($apiKey.Length-4))"
Write-Host "    模型：$model"
Write-Host ""

# 检查网络
Write-Host "正在检查网络连接..." -ForegroundColor Yellow
try {
    $testUrl = "https://raw.githubusercontent.com"
    $request = [System.Net.WebRequest]::Create($testUrl)
    $request.Timeout = 3000
    $response = $request.GetResponse()
    Write-Host "[✓] 网络连接正常" -ForegroundColor Green
} catch {
    Write-Host "[!] 网络可能不稳定" -ForegroundColor Yellow
    Write-Host "    如果部署失败，请检查网络后重试"
}
Write-Host ""

# 开始部署
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  开始部署" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "这可能需要 2-5 分钟，请稍候..." -ForegroundColor Yellow
Write-Host ""

# 检查是否需要安装 WSL
Write-Host "[1/4] 检查 WSL..." -ForegroundColor Cyan
$wslStatus = wsl --list 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "[!] 未检测到 WSL，正在安装..." -ForegroundColor Yellow
    Write-Host ""
    wsl --install
    Write-Host ""
    Write-Host "[!] WSL 安装完成后需要重启电脑" -ForegroundColor Red
    Write-Host "[!] 重启后请重新运行此部署工具" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按回车键退出"
    exit 1
}
Write-Host "[OK] WSL 已安装" -ForegroundColor Green
Write-Host ""

# 执行部署脚本
Write-Host "[2/4] 开始部署..." -ForegroundColor Cyan
Write-Host ""

$installScript = @"
curl -fsSL 'https://raw.githubusercontent.com/openclaw/openclaw/main/site/scripts/install-lobster-cn.sh' | bash -s -- --api-key '$apiKey' --base-url '$baseUrl' --model '$model'
"@

try {
    $result = wsl bash -c $installScript 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "  部署完成！" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "访问地址：http://localhost:18789" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "📁 安装目录：~/lobster-ai" -ForegroundColor White
        Write-Host "📄 配置文件：~/lobster-ai/.env" -ForegroundColor White
        Write-Host ""
    } else {
        Write-Host ""
        Write-Host "[错误] 部署失败" -ForegroundColor Red
        Write-Host "错误信息：$result" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "请检查网络或联系支持" -ForegroundColor Yellow
    }
} catch {
    Write-Host ""
    Write-Host "[错误] 部署失败" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
}

Write-Host ""
Read-Host "按回车键退出"
