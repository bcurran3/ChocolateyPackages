$packageName    = 'getdataback-simple'
$installerType  = 'exe'
$url            = 'https://www.runtime.org/gdbsimsetup.exe'
$checksum       = '8053FAC586B6B089982E8731B4FC9B46B0E0A3B96499FDE5C4D09B72625A0222'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0)
$softwareName   = 'GetDataBack Simple*'

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
