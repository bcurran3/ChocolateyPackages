$packageName    = 'pst-merger' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://d.4team.biz/files/pstmerger_setup.exe'
$checksum       = '83875C466B4B80A6ADDD2026793122CAC9213D1F7851CAB04756C77704AFD4D5'
$validExitCodes = @(0,2)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "PSTMergerInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'exe' 
  url            = $url
  silentArgs     = '' 
  validExitCodes = $validExitCodes
  softwareName   = '4Team PST Merger*' 
  checksum       = $checksum
  checksumType   = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

