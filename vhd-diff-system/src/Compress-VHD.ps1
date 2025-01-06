param (
    [string]$VHDPath
)

if (-not (Test-Path $VHDPath)) {
    Write-Host "指定的VHD文件不存在: $VHDPath"
    exit
}

try {
    $command = @(
        "select vdisk file=`"$VHDPath`""
        "compact vdisk"
    )

    $command | diskpart
    Write-Host "VHD文件已成功压缩: $VHDPath"
} catch {
    Write-Host "压缩VHD文件时发生错误: $_"
}