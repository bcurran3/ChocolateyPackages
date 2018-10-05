$ErrorActionPreference = 'Stop'; 
$packageName = 'setpoint' 
$url         = 'https://www.logitech.com/pub/techsupport/mouse/SetPoint6.69.114_32.exe'
$checksum    = 'CF42257EA96F0ACA2BD22FDBE38C345E5D5999890B3F21AE8493A323BBA6E5B9'
$url64       = 'https://www.logitech.com/pub/techsupport/mouse/SetPoint6.69.114_64.exe'
$checksum64  = '917EB50C3D063169071B0FA51197A42262DB0A508B105B1B6D4FB2757B72E856'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
  url64bit      = $url64  
  checksum64    = $checksum64
  checksumType64= 'sha256'  
  silentArgs    = '/S'
  softwareName  = 'Logitech SetPoint*' 
  }
  
Install-ChocolateyPackage @packageArgs
