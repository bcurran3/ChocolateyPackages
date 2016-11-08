$ErrorActionPreference = 'Stop';
$packageName= 'netfx-repair-tool'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/2/B/D/2BDE5459-2225-48B8-830C-AE19CAF038F1/NetFxRepairTool.exe'
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
$installerPackage = Join-Path $scriptDir "NetFxRepairTool.exe";

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = ''
  checksum      = '6CEACE07FF687B3B5B2DE1B719B05E4F8C93888DA937DE0CA566B26DCB27C124'
  checksumType  = 'sha256'
}


Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Microsoft .NET Framework Repair Tool.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\NetFxRepairTool.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft .NET Framework Repair Tool.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\NetFxRepairTool.exe"














