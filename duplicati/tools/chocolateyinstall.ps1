$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.34-2.0.1.34_canary_2016-12-05/duplicati-2.0.1.34_canary_2016-12-05-x86.msi' 
$checksum      = 'E671F43ABD7DD34CDAC10880CA48F2FD983BD3F4490DBBFCEBAF91B6F2132984'
$url64         = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.34-2.0.1.34_canary_2016-12-05/duplicati-2.0.1.34_canary_2016-12-05-x64.msi' 
$checksum64    = 'E6545C5A2953EFD33C5E270E5BAABEB049B3B3D280BF60818CE33508C293ACA3'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

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
  
