$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://allwaysync.com/content/download/allwaysync.exe'
$checksum    = 'D97CBDB54C10D008918E8C97E3EA7F506B99962D2373347C1D2CB1753CF30719'
$url64       = 'https://allwaysync.com/content/download/allwaysync-x64.exe'
$checksum64  = 'B6D72B4D9EBF64ABDD1443AFB22C619145AA66634FECC8195E81FA45AB372F75'

$packageArgs = @{
  packageName    = 'allway-sync'
  fileType       = 'exe' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'  
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName   = 'Allway Sync*' 
  }
  
Install-ChocolateyPackage @packageArgs
