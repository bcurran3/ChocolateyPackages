$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.32-2.0.1.32_canary_2016-11-12/duplicati-2.0.1.32_canary_2016-11-12-x86.msi' 
$checksum      = 'E6E8CE6DEB8C8331A15ACCED074F5569EFE292C851C9DC9ECBC4BE1BB6C90FC0'
$url64         = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.32-2.0.1.32_canary_2016-11-12/duplicati-2.0.1.32_canary_2016-11-12-x64.msi' 
$checksum64    = '01604C84828F14FBA9C24CF78C921EAB4C790D49F9294322566716FF9F1839F9'
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
  
