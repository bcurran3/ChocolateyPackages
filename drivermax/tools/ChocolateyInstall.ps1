$packageName    = 'drivermax' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.drivermax.com/soft/dmx/drivermax.exe'
$checksum       = '270EF5232F062EA677ECD452F9D35B4BC54A8673EC17CF4679D8D662A6772DD0'
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
  
Show-Patreon "https://www.patreon.com/bcurran3"  
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

