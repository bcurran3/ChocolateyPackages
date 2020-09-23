$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$silentArgs     = ''
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\PellesCInstall.ahk"

$packageArgs = @{
  packageName    = 'pelles-c'
  softwareName   = 'Pelles C for Windows'
  fileType       = 'EXE'
  silentArgs     = ''
  file           = "$toolsDir\setup.exe"
  validExitCodes = @(0, 3010, 1641)
  }

Start-Process $ahkExe $ahkFile  
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.exe -Force | Out-Null
Remove-Item $toolsDir\*.ignore -Force | Out-Null