# Initialize-Environment.ps1

# 设置移动硬盘的盘符
$driveLetter = "E"

# 创建必要的文件夹
$folders = @(
    "$($driveLetter):\0ImageFiles",
    "$($driveLetter):\1ProgramFiles",
    "$($driveLetter):\2Environment"
)

foreach ($folder in $folders) {
    if (-Not (Test-Path -Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force
    }
}

# 设置软链接文件夹
$junctions = @(
    "$($driveLetter):\Program Files",
    "$($driveLetter):\Program Files (x86)"
)

foreach ($junction in $junctions) {
    if (-Not (Test-Path -Path $junction)) {
        (New-Item -ItemType Junction -Path $junction -Value "$($driveLetter):\1ProgramFiles" -Force).Attributes = [System.IO.FileAttributes]::Hidden + [System.IO.FileAttributes]::System
    }
}

Write-Host "环境初始化完成，必要的文件夹和软链接已创建。"