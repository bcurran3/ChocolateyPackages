$packageName    = 'screenlogic-connect'
$installerType  = 'exe'
$url            = 'http://www.pentairpool.com/downloads/screenlogic/733/XP/SetupScreenlogicConnect.exe'
$checksum       = 'E56B424F48B1DB5D1D7342E9D9672BC621E2B8C7AD357B7274D3F3713D456E12'
$silentArgs     = '/quiet'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Pentair ScreenLogic'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

