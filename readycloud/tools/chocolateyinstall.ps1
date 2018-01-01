$ErrorActionPreference = 'Stop'
$packageName = 'readycloud' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://readycloud.netgear.com/client/install/ReadyCloudSetup.exe'
$checksum    = '36400DAE69FBE5A695EBBFF54546EA64152D74FCD7386B6DB8BA6A5AD303D618'
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
