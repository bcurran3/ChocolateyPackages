$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.6.3-2.0.6.3_beta_2021-06-17/duplicati-2.0.6.3_beta_2021-06-17-x86.msi'
$checksum       = 'EB8BCA03125F37F956BD36BCB6B00D7D3F4D60C1DDBFB6EACCE43C18FE206D04'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.0.6.3-2.0.6.3_beta_2021-06-17/duplicati-2.0.6.3_beta_2021-06-17-x64.msi'
$checksum64     = '9A442CED41F0F9A0142618CE04B67D56C49D9E1C215A2FFCC13F8309428E3ABC'

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
  
