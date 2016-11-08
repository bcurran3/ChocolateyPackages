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
  checksum      = '80FB64567A25C1A2EF45F0FA4DD892AB887EB44131EC6D89B2E449906D7041AA'
  checksumType  = 'sha256'
  }
Install-ChocolateyPackage @packageArgs

