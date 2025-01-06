# VHDModule.psm1

# 导入子模块
Import-Module "$PSScriptRoot\src\New-DiffVHD.ps1"
Import-Module "$PSScriptRoot\src\Initialize-Environment.ps1"
Import-Module "$PSScriptRoot\src\Compress-VHD.ps1"
Import-Module "$PSScriptRoot\src\Get-VHDInfo.ps1"

# 导出函数
Export-ModuleMember -Function New-DiffVHD, Initialize-Environment, Compress-VHD, Get-VHDInfo