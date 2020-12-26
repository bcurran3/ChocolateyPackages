# https://www.majorgeeks.com/files/details/win7codecs.html
$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\advanced-codecs_install.ahk"
$culture        = Get-Culture
$LCID           = $culture.LCID
$TodaysVersion  = $env:ChocolateyPackageVersion -replace '[.]',''

$packageArgs = @{
  packageName    = 'advanced-codecs'
  softwareName   = 'Shark007 ADVANCED*'
  fileType       = 'EXE'
  silentArgs     = "/S /v/qn /l$LCID"
  file           = "$toolsDir\ADVANCED_Codecs_v"+$TodaysVersion+".exe"
  validExitCodes = @(0, 3010, 1641)
  }
  
Start-Process $ahkExe $ahkFile  
Install-ChocolateyInstallPackage @packageArgs
Start-Sleep -s 20
Start-CheckandStop "Settings32"
Start-CheckandStop "Settings64"
Start-CheckandStop "AutoHotkey"
Remove-Item $toolsDir\*.exe -Force -EA SilentlyContinue | Out-Null
