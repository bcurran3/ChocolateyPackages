$ErrorActionPreference = 'Stop'; 
$packageName = 'setpoint' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://www.logitech.com/pub/techsupport/mouse/SetPoint6.67.83_32.exe'
$url64       = 'http://www.logitech.com/pub/techsupport/mouse/SetPoint6.67.83_64.exe'
$silentArgs  = '/S' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = '1E60A1B0B302AD3B116B29DFE736FCEECF4DA21D4FF9CF0288E86EB14FA79210'
  checksumType  = 'sha256' 
  url64bit      = $url64  
  checksum64    = '11650114A18EEB4F6BE75462C6D93891C31BB95D8BE908503854832071B1683E'
  checksumType64= 'sha256'  
  silentArgs    = $silentArgs 
  softwareName  = 'Logitech SetPoint*' 
  }
  
Install-ChocolateyPackage @packageArgs
