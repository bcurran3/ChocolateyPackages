$ErrorActionPreference = 'Stop'; 
$packageName = 'setpoint' 
$url         = 'https://www.logitech.com/pub/techsupport/mouse/SetPoint6.69.123_32.exe'
$checksum    = '20BD1FA910B0F93A90D578273756D9E1D9A17DCCBF7E82EAD7C3BAF98B7AC8A1'
$url64       = 'https://www.logitech.com/pub/techsupport/mouse/SetPoint6.69.123_64.exe'
$checksum64  = '49E819BC4DE417299274E492871DB0086A48EA01F4CCB982EC0D7C72B20401DA'

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
