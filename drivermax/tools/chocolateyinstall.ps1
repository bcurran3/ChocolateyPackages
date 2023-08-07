$ErrorActionPreference = 'Stop'
$packageName = 'drivermax' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum    = '84B01BCDAF54A7386627BD930A6F8B74D9C0751A711424B374ADBB1C1210392F'

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

# Update instructions:
# Update checksum
