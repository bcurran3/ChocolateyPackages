$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.42-2.0.1.42_canary_2017-01-16/duplicati-2.0.1.42_canary_2017-01-16-x86.msi' 
$checksum      = '0040D58F2A713702DD23916EA7F516984FDCCE35A288F680F7CF1E758E35FCCE'
$url64         = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.42-2.0.1.42_canary_2017-01-16/duplicati-2.0.1.42_canary_2017-01-16-x64.msi' 
$checksum64    = '6F225A99EC7ABB65EDA36C3A3C2EE79FDF2A70C24FBC75770BD4F7E94A5E42FD'
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
  
