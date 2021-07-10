$ErrorActionPreference = 'Stop'
$packageName = 'drivermax' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum    = 'FF4A804EB0368DEF4C3BFC3061FE91D4D4A5C3D134ED4369AC6317E91D133038'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url            = $url
  validExitCodes = @(0,1)
  silentArgs     = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' 
  softwareName   = 'DriverMax*' 
  checksum       = $checksum
  checksumType   = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs
