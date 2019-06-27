$ErrorActionPreference = 'Stop'
$packageName    = 'drivermax' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum       = '8590C2601084796C427B80A05EFC5C4470584F3D49D5B63A24CD4DCA49CCD8BF'

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
