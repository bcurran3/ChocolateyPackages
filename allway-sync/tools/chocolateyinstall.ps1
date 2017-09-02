$ErrorActionPreference = 'Stop'
$packageName = 'allway-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://allwaysync.com/content/download/allwaysync-17-2-8.exe'
$checksum    = 'DE721B43A89DFB4CC2F016A5E6EA295F0F8EB2EFF59898B6218C5D3478D08009'
$url64       = 'https://allwaysync.com/content/download/allwaysync-x64-17-2-8.exe'
$checksum64  = '73EF2F702D5EDB08B0D9EE788B1B1044B5AD0FAE8DDD1E898AB524C237F8D91F'
$silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = $silentArgs
  softwareName  = 'Allway Sync*' 
  }
Install-ChocolateyPackage @packageArgs
