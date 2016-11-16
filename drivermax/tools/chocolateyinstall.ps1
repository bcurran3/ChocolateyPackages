$packageName= 'drivermax' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.drivermax.com/soft/dmx/drivermax.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' 
  softwareName  = 'DriverMax*' 
  checksum      = '5DF136266CD61ED8D85A6E343B0E7A6C64C5321823189CCC3D08FCAA4C111DE7'
  checksumType  = 'sha256'
  }
Install-ChocolateyPackage @packageArgs

