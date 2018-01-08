$ErrorActionPreference = 'Stop'
$packageName   = 'googleearth'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://dl.google.com/earth/client/GE7/release_7_1_8/googleearth-win-7.1.8.3036.exe' 
$checksum      = 'B64FFC6F31E3E42F154E7D19DFA301376DE987403A9C50B575DAC04022E06576'
$silentArgs    = 'OMAHA=1'
$validExitCodes= @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Google Earth*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs 
