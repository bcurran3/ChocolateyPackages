$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.47-2.0.1.47_canary_2017-02-14/duplicati-2.0.1.47_canary_2017-02-14-x86.msi' 
$checksum      = '124305080CA683036905AFBABC7669D5D3773079D6CFEE181ECC47792575A27D'
$url64         = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.47-2.0.1.47_canary_2017-02-14/duplicati-2.0.1.47_canary_2017-02-14-x64.msi' 
$checksum64    = 'DA505CDED19A2C5F10698251104E406D3BB33E58760B0D679E1757F16C974FDD'
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
  
