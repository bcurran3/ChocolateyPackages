$ErrorActionPreference = 'Stop'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$packageName    = 'wordweb-free'
$url            = "$toolsDir\wordweb8.exe"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\wordweb-free-install.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  validExitCodes = @(0)
  silentArgs     = '/s'
  softwareName   = 'WordWeb'
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
Remove-Item $toolsDir\*.ignore -force | Out-Null
