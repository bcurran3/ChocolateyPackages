$ErrorActionPreference = 'Stop'; 
$packageName = 'setpoint' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.logitech.com/pub/techsupport/mouse/SetPoint6.68.250_32.exe'
$checksum    = '8C83874F83AB8580D3A345C550C9834F277EFD2E1C393535D11BD5D702DD79EE'
$url64       = 'https://www.logitech.com/pub/techsupport/mouse/SetPoint6.68.250_64.exe'
$checksum64  = '9948B0ACE1B91C416141EF8C73C2D944D19BBD6135D26FC6A4B34F7393D1AF21'
$silentArgs  = '/S' 

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
  softwareName  = 'Logitech SetPoint*' 
  }
  
Install-ChocolateyPackage @packageArgs
