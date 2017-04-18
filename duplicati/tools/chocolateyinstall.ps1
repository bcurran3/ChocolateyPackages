$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.55-2.0.1.55_canary_2017-04-06/duplicati-2.0.1.55_canary_2017-04-06-x86.msi' 
$checksum       = '02F1C180B94D19F5B2597AECE46D6F5C97B86FBEA1BAF3F74889613ADC46EC2F'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.55-2.0.1.55_canary_2017-04-06/duplicati-2.0.1.55_canary_2017-04-06-x64.msi' 
$checksum64     = '2C6AF4EE835518A2645D06E752097881EF9BE0E889BCBB1D4F1D7571551AD35B'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Duplicati 2*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
