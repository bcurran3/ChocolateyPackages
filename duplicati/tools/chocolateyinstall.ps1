$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.53-2.0.1.53_experimental_2017-03-13/duplicati-2.0.1.53_experimental_2017-03-13-x86.msi' 
$checksum       = '388CDE155D025D8BC174E825605EB1AEC8F26D3C455412A966B5B3F4CBA1E0A5'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.53-2.0.1.53_experimental_2017-03-13/duplicati-2.0.1.53_experimental_2017-03-13-x64.msi' 
$checksum64     = '4E07C9B626EE3D99C3DB94D79AD565DE7B120F3E79D5C1308F0DC3116FCDE226'
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
  
