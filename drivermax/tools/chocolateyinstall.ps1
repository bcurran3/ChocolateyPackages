$ErrorActionPreference = 'Stop'
$packageName = 'drivermax' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum    = '3219CD4B6681741E96060B310411E39AC8963DF88EE48C3158D9E1D28025BA04'

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
