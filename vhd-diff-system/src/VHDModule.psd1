@{
    ModuleVersion = '1.0.0'
    GUID = '81cd388e-f0ed-4edc-98d7-2b9dedd7c5b7'
    Author = 'Your Name'
    CompanyName = 'Your Company'
    Copyright = 'Copyright © Your Company 2024'
    Description = '此模块用于生成基于base.vhd的差分VHD文件，并提供环境初始化和压缩功能。'
    FunctionsToExport = @('New-DiffVHD', 'Initialize-Environment', 'Compress-VHD', 'Get-VHDInfo')
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
}