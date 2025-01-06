function Get-VHDInfo {
    param (
        [Parameter(Mandatory = $true)]  # 参数：VHD文件夹路径，必填
        [string]$VHDPath,
        
        [Parameter(Mandatory = $true)]  # 参数：系统名称，必填
        [string]$VHDName
    )

    # 构建各个VHD文件的路径
    $baseVHD = Join-Path -Path $VHDPath -ChildPath "${VHDName}_base.vhd"
    $vhd = Join-Path -Path $VHDPath -ChildPath "${VHDName}.vhd"
    $recoveryVHD = Join-Path -Path $VHDPath -ChildPath "${VHDName}_r.vhd"
    $cacheVHD = Join-Path -Path $VHDPath -ChildPath "${VHDName}_cache.vhd"

    # 将所有VHD文件路径存入数组
    $vhdFiles = @($baseVHD, $vhd, $recoveryVHD, $cacheVHD)

    # 遍历每个VHD文件路径
    foreach ($file in $vhdFiles) {
        if (Test-Path $file) {  # 如果文件存在
            Get-Item $file | Select-Object Name, Length, CreationTime, LastWriteTime  # 获取文件信息
        } else {
            Write-Output "$file 不存在"  # 如果文件不存在，输出提示信息
        }
    }
}
