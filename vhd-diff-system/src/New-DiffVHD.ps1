param (
    [string]$VHDPath,
    [string]$NewVHDName
)

function New-BaseVHD {
    param (
        [string]$VHDPath
    )

    $baseVHD = Join-Path -Path $VHDPath -ChildPath "base.vhd"
    $bakVHD = Join-Path -Path $VHDPath -ChildPath "bak.vhd"

    if (-Not (Test-Path $baseVHD)) {
        # 如果 base.vhd 不存在，则创建一个新的 base.vhd, 并将其备份为 bak.vhd
        # 创建一个 2TB 的动态扩展 VHD 文件
        $command = @(
            "create vdisk file=`"$baseVHD`" maximum=2048 type=expandable"
        )


        # 差分bak.vhd文件
        $command += @(
            "create vdisk file=`"$bakVHD`" parent=`"$baseVHD`" noerr"
        )

        $command + "exit" | diskpart

        Write-Host "base.vhd 文件已成功创建在 $VHDPath"
    } else {
        Write-Host "base.vhd 文件已存在于路径 $VHDPath"
    }

}

function New-DiffVHDFile {
    param (
        [string]$baseVHD,
        [string]$diffVHD,
        [string]$outputDir
    )

    if (-Not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force
    }
    $diffVHDPath = Join-Path -Path $outputDir -ChildPath "$diffVHD.vhd"
    $command = @(
        "create vdisk file=`"$diffVHDPath`" parent=`"$baseVHD`""
    )

    diskpart -Input $command

}

function New-DiffVHD {
    param (
        [string]$VHDPath,
        [string]$NewVHDName
    )

    $baseVHD = Join-Path -Path $VHDPath -ChildPath "base.vhd"
    $bakVHD = Join-Path -Path $VHDPath -ChildPath "bak.vhd"
    $newBaseVHD = Join-Path -Path $VHDPath -ChildPath "$NewVHDName`_base.vhd"
    # $newVHD variable removed as it was not used
    $cacheVHD = Join-Path -Path $VHDPath -ChildPath "$NewVHDName`_cache.vhd"

    if (-Not (Test-Path $baseVHD)) {
        Write-Host "错误: base.vhd 文件不存在于路径 $VHDPath"
        return
    }

    if (-Not (Test-Path $bakVHD)) {
        New-DiffVHDFile -baseVHD $baseVHD -diffVHD "bak" -outputDir $VHDPath
    }

    Copy-Item -Path $bakVHD -Destination $newBaseVHD -Force
    New-DiffVHDFile -baseVHD $newBaseVHD -diffVHD $NewVHDName -outputDir $VHDPath
    New-Item -Path $cacheVHD -ItemType File -Force

    Write-Host "差分VHD文件已成功创建在 $VHDPath"
}

$VHDPath = "D:\0ImageFiles\Windows11\Images"
$NewVHDName = "Win"
# New-BaseVHD -VHDPath $VHDPath
New-DiffVHD -VHDPath $VHDPath -NewVHDName $NewVHDName