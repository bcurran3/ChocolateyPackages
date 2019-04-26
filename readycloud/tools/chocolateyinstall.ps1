$ErrorActionPreference = 'Stop'
$packageName = 'readycloud' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://readycloud.netgear.com/client/install/ReadyCloudSetup.exe'
$checksum    = '5CA8918CD53384A6660863601AE528415AC14F1C3A5CA8C5E1DC04411979F67B'
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\ReadyCLOUDinstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = ''
  softwareName  = 'ReadyCLOUD' 
  }
  
Install-ChocolateyPackage @packageArgs
