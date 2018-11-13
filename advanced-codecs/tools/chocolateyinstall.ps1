# https://www.majorgeeks.com/files/details/win7codecs.html
$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\ADVANCED_Codecs_v1074.exe"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\advanced-codecs_install.ahk"

$packageArgs = @{
  packageName    = 'advanced-codecs'
  softwareName   = 'Shark007 ADVANCED Codecs*'
  fileType       = 'EXE'
  silentArgs     = '/S /v/qn'
  file           = $url
  validExitCodes = @(0, 3010, 1641)
  }
Start-Process $ahkExe $ahkFile  
Install-ChocolateyInstallPackage @packageArgs
Start-Sleep -s 10
Start-CheckandStop "Settings32"
Start-CheckandStop "Settings64"
Start-CheckandStop "AutoHotkey"
Remove-Item $url
