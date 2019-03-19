$ErrorActionPreference = 'Stop'
$packageName    = 'pst-merger' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://d.4team.biz/files/pstmerger_setup.exe'
$checksum       = '2EBFAFC74FDB4B1943423B8FAD4447887237F084427767CC022B827212A92023'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\PSTMergerInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url            = $url
  silentArgs     = '' 
  validExitCodes = @(0,2)
  softwareName   = '4Team PST Merger*' 
  checksum       = $checksum
  checksumType   = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs
Start-Sleep 10
Start-CheckandStop "PSTMerger"
Start-CheckandStop "4Team-Updater"
