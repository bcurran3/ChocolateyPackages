$ErrorActionPreference = 'Stop'
$packageName = 'allway-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://allwaysync.com/content/download/allwaysync-17-1-3.exe'
$checksum    = '13F7279EEA696F8EB0077A960F957ACF91C38B128B5F3FF56C98B89699E23EAE'
$url64       = 'https://allwaysync.com/content/download/allwaysync-x64-17-1-3.exe'
$checksum64  = '3D5E2C11468152601C13806408EAE57B72A1AEA2276EB24BB94AD75E54F19DF3'
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
