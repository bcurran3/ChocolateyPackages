$ErrorActionPreference = 'Stop'
$packageName = 'readycloud' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://readycloud.netgear.com/client/install/ReadyCloudSetup.exe'
$checksum    = '39D80FBA1EF3195B01961CC93D1E52B1EB57AE32ADB552A5B5B27955D1A5A3E5'
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
