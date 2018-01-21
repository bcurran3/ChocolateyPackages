$ErrorActionPreference = 'Stop'
$packageName= 'osfmount' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.osforensics.com/downloads/osfmount.exe'
$checksum   = '2932094021D4CCF6FF17EAEEC27C6F0AC44F0F5BF233D3C08B87601723D88A8F'
$url64      = 'http://www.osforensics.com/downloads/osfmount_x64.exe'
$checksum64 = '2229886CA7586E3CACA37536B3D69127713F1613920161428C47948DBE8C4546'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

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
  softwareName  = 'OSFMount*' 
  }
Install-ChocolateyPackage @packageArgs
