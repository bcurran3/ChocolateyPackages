$ErrorActionPreference = 'Stop'
$packageName = 'allway-sync' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://allwaysync.com/content/download/allwaysync-17-2-17.exe'
$checksum    = '7C8E33C85AF40A12C792A6E8CEBD302749EE74C2196061674B57764A68D2E8A6'
$url64       = 'https://allwaysync.com/content/download/allwaysync-x64-17-2-17.exe'
$checksum64  = '05813F2247CF89A3DCFD9570AFFC5B4A781F4B2DC314A2F4D9EAE860587333DD'
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
