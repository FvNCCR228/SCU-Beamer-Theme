# install-plugin.ps1: SCU Beamer Theme 扩展主题插件安装脚本 (Windows)
#                     支持从 GitHub 仓库下载指定文件到项目中
# 用法: .\install-plugin.ps1 -e <插件名> [-nogit]
# 示例: .\install-plugin.ps1 -e example
# 列表: .\install-plugin.ps1 -l
# 搜索: .\install-plugin.ps1 -s <关键词>

# ----------------------------------------
# 设置 UTF-8 编码
# ----------------------------------------

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# ----------------------------------------
# 加载插件配置
# ----------------------------------------

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfFile = Join-Path $ScriptDir "plugins.conf"

$Plugins  = @{}
$Branches = @{}
$Files    = @{}
$Names    = @{}

function Load-Plugins {
    if (-not (Test-Path $ConfFile)) {
        Write-Host "错误: 配置文件 $ConfFile 不存在" -ForegroundColor Red
        exit 1
    }

    $section = ""
    foreach ($line in Get-Content $ConfFile -Encoding UTF8) {
        $line = $line.Trim()

        # 跳过空行和注释
        if ($line -eq "" -or $line.StartsWith("#")) { continue }

        # 解析 section [name]
        if ($line -match "^\[(.+)\]$") {
            $section = $Matches[1]
            continue
        }

        if ($section -eq "") { continue }

        # 解析 key = value
        if ($line -match "^(.*?)=(.*)$") {
            $key   = $Matches[1].Trim()
            $value = $Matches[2].Trim()
            switch ($key) {
                "repo"   { $Plugins[$section]  = $value }
                "branch" { $Branches[$section] = $value }
                "files"  { $Files[$section]    = $value }
                "name"   { $Names[$section]    = $value }
            }
        }
    }
}

Load-Plugins

# ----------------------------------------
# 解析参数
# ----------------------------------------

$PluginName = ""
$NoGit = $false
$DoList = $false
$SearchKey = ""

$i = 0
while ($i -lt $args.Count) {
    switch ($args[$i]) {
        "-e" {
            $i++
            if ($i -lt $args.Count -and $args[$i] -notmatch "^-") {
                $PluginName = $args[$i]
            } else {
                Write-Host "错误: -e 选项需要指定插件名" -ForegroundColor Red
                exit 1
            }
        }
        "-l" { $DoList = $true }
        "-s" {
            $i++
            if ($i -lt $args.Count -and $args[$i] -notmatch "^-") {
                $SearchKey = $args[$i]
            }
        }
        "-nogit" { $NoGit = $true }
        default {
            Write-Host "用法:"
            Write-Host "  .\install-plugin.ps1 -e <插件名> [-nogit] 安装插件"
            Write-Host "  .\install-plugin.ps1 -l 列出所有插件"
            Write-Host "  .\install-plugin.ps1 -s [<关键词>] 搜索插件"
            exit 1
        }
    }
    $i++
}

if ($DoList) {
    Write-Host "可用插件:"
    foreach ($key in $Plugins.Keys) {
        Write-Host "  $key - $($Names[$key])"
    }
    exit 0
}

if ($SearchKey -ne "" -or ($args -contains "-s")) {
    Write-Host "搜索结果:"
    foreach ($key in $Plugins.Keys) {
        if ($SearchKey -eq "" -or $key -like "*$SearchKey*" -or $Names[$key] -like "*$SearchKey*") {
            Write-Host "  $key - $($Names[$key])"
        }
    }
    exit 0
}

if ($PluginName -eq "") {
    Write-Host "错误: 请指定插件名" -ForegroundColor Red
    Write-Host "用法:"
    Write-Host "  .\install-plugin.ps1 -e <插件名> [-nogit] 安装插件"
    Write-Host "  .\install-plugin.ps1 -l 列出所有插件"
    Write-Host "  .\install-plugin.ps1 -s [<关键词>] 搜索插件"
    exit 1
}

# ----------------------------------------
# 校验插件
# ----------------------------------------

$Repo     = $Plugins[$PluginName]
$Branch   = $Branches[$PluginName]
$FileList = $Files[$PluginName] -split "\s+"

# ----------------------------------------
# 下载插件文件
# ----------------------------------------

$UseGit = $false
if (-not $NoGit -and (Get-Command git -ErrorAction SilentlyContinue)) {
    $UseGit = $true
}

Write-Host "正在从 $Repo 下载插件 '$($Names[$PluginName])'..., 包含文件: $($Files[$PluginName])" -ForegroundColor Green

$CacheDir = Join-Path "." "tmp\plug\plug-$PluginName"
New-Item -ItemType Directory -Path $CacheDir -Force | Out-Null

if ($PluginName -ne "example") {
    if ($UseGit) {
        # 使用 git sparse-checkout 下载
        Write-Host "使用 git 下载..." -ForegroundColor Green
        $TempDir = Join-Path $env:TEMP "plugin-$([guid]::NewGuid().ToString('N').Substring(0,8))"
        $OriginalDir = Get-Location
        git clone --depth 1 --filter=blob:none --sparse "https://github.com/$Repo" $TempDir
        Set-Location $TempDir
        git sparse-checkout set $FileList
        Set-Location $OriginalDir
        foreach ($item in $FileList) {
            $destPath = Join-Path $CacheDir (Split-Path $item -Parent)
            if ($destPath -and -not (Test-Path $destPath)) {
                New-Item -ItemType Directory -Path $destPath -Force | Out-Null
            }
            Copy-Item (Join-Path $TempDir $item) (Join-Path $CacheDir $item) -Force
        }
        Remove-Item $TempDir -Recurse -Force
    } else {
        # 使用 Invoke-WebRequest 下载
        Write-Host "使用 Invoke-WebRequest 下载..." -ForegroundColor Green
        foreach ($item in $FileList) {
            $url  = "https://raw.githubusercontent.com/$Repo/$Branch/$item"
            $dest = Join-Path $CacheDir $item

            Write-Host "  下载 $item..."
            $destParent = Split-Path $dest -Parent
            if ($destParent -and -not (Test-Path $destParent)) {
                New-Item -ItemType Directory -Path $destParent -Force | Out-Null
            }
            Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        }
    }
} else {
    # 示例模式: 仅打印下载命令, 不实际下载
    foreach ($item in $FileList) {
        $url  = "https://raw.githubusercontent.com/$Repo/$Branch/$item"
        $dest = Join-Path $CacheDir $item

        Write-Host "  下载 $item... Invoke-WebRequest -Uri $url -OutFile $dest"
        $destParent = Split-Path $dest -Parent
        if ($destParent -and -not (Test-Path $destParent)) {
            New-Item -ItemType Directory -Path $destParent -Force | Out-Null
        }
    }
}

Write-Host "下载完成!" -ForegroundColor Green

# ----------------------------------------
# 复制到工作目录
# ----------------------------------------

$WorkDir = (Get-Location).Path
Write-Host "正在复制文件到工作目录 $WorkDir..." -ForegroundColor Green

foreach ($item in $FileList) {
    $src  = Join-Path $CacheDir $item
    $dest = Join-Path $WorkDir $item

    $destParent = Split-Path $dest -Parent
    if ($destParent -and -not (Test-Path $destParent)) {
        New-Item -ItemType Directory -Path $destParent -Force | Out-Null
    }

    if (Test-Path $dest) {
        Write-Host "冲突: $dest 已存在" -ForegroundColor Green
        $choice = Read-Host "保留哪个？(1=现有文件 2=新文件)"
        if ($choice -eq "2") {
            Copy-Item $src $dest -Force
            Write-Host "已覆盖 $dest" -ForegroundColor Green
        } else {
            Write-Host "保留现有文件 $dest" -ForegroundColor Green
        }
    } else {
        Copy-Item $src $dest
    }
}

Write-Host "插件 '$($Names[$PluginName])' 安装完成!" -ForegroundColor Green

# ----------------------------------------
# 清理缓存
# ----------------------------------------

$reply = Read-Host "是否删除缓存目录 $CacheDir?(y/n)"
if ($reply -match "^[Yy]") {
    Remove-Item $CacheDir -Recurse -Force
    Write-Host "已删除 $CacheDir" -ForegroundColor Green
}
