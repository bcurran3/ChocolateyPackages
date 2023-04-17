$ErrorActionPreference = 'Stop'
$packageName = 'drivermax' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum    = '804B5689C7781C11DFA8FA13340BA739261378F5A49B1B163C46AAD87E828058'

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
