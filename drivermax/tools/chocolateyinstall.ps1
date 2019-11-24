$ErrorActionPreference = 'Stop'
$packageName    = 'drivermax' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum       = '218F86C9D1E042C065DBBA3ACED69C22D1DBD25EE4FDEC9F7C9EC88B1A5B72D2'

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
