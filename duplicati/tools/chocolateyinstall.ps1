$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.4.5-2.0.4.5_beta_2018-11-28/duplicati-2.0.4.5_beta_2018-11-28-x86.msi' 
$checksum       = 'B3C594AF2FB357BBDD7FDA405F02764E3FF89BB69B0F781FD08190A2FE6787D9'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.0.4.5-2.0.4.5_beta_2018-11-28/duplicati-2.0.4.5_beta_2018-11-28-x64.msi' 
$checksum64     = 'E5C0FF6E7D3D9B66F37D105AC16EF787331EE7104ADC5813AA23628160829F75'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64bit       = $url64
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'Duplicati 2*'
  checksum       = $checksum 
  checksumType   = 'sha256' 
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
