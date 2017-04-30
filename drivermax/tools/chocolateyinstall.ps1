$packageName = 'drivermax' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum    = '9C9421DC1E4A4275219CB0C370A10C4F7D07FE5DE55600C15DB7C4D249128BC8'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs    = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' 
  softwareName  = 'DriverMax*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

