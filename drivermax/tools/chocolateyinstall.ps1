$packageName = 'drivermax' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum    = '23F2EDF9C81D0BB45E3958206AE32DC41DCAB7ADC336D2B63BC6DEB3BF2C603C'

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

