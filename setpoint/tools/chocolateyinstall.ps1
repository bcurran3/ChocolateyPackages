$ErrorActionPreference = 'Stop'; 
$packageName = 'setpoint' 
$url         = 'https://download01.logi.com/web/ftp/pub/techsupport/mouse/SetPoint6.70.55_32.exe'
$checksum    = '6692518B9443284E661F824465B1FE35B096411CF98F22D60B6AE6441E041871'
$url64       = 'https://download01.logi.com/web/ftp/pub/techsupport/mouse/SetPoint6.70.55_64.exe'
$checksum64  = '77D4F313F4112BBB6D414804D71810AF918AB4EF71F55DABC2007B4086CB7BDE'

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
