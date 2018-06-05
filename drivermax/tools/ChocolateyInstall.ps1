$packageName    = 'drivermax' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum       = '5263DF09DBA92F5430CC084FFB87EF71C746FB335F6CC7157774B449A0562EE9'
$validExitCodes = @(0, 1)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  validExitCodes= $validExitCodes  
  silentArgs    = '/SP- /VERYSILENT /SUPPRESSMSGBOXES /CLOSEAPPLICATIONS' 
  softwareName  = 'DriverMax*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

