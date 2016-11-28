$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.33-2.0.1.33_canary_2016-11-27/duplicati-2.0.1.33_canary_2016-11-27-x86.msi' 
$checksum      = '6EB654ACFE2E3F25247DF18BF9C737BDFC0EB16E4B940261BC69D17D0D9D1736'
$url64         = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.33-2.0.1.33_canary_2016-11-27/duplicati-2.0.1.33_canary_2016-11-27-x64.msi' 
$checksum64    = '64FF3BA3DB027D2D253383FECD782AA3812D99F6F827C4D655E9675EF83E67A4'
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
  
