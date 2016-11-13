$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.31-2.0.1.31_canary_2016-11-03/duplicati-2.0.1.31_canary_2016-11-03-x86.msi' 
$checksum      = '4C4A96656F6EF39514D8C49CD88E3EFF15AB81D3ACC6AF073D6770FC045204BD'
$url64         = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.31-2.0.1.31_canary_2016-11-03/duplicati-2.0.1.31_canary_2016-11-03-x64.msi' 
$checksum64    = '7401BA3B0A425B25E20B7E45A33A753E569D365F3A8D59AE10BEA96E8665FEB6'
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
  
