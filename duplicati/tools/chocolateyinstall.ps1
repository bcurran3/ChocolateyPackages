$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.2.1-2.0.2.1_beta_2017-08-01/duplicati-2.0.2.1_beta_2017-08-01-x86.msi' 
$checksum       = 'B68461016B2F4D4F07F9998492C37F0D3BED3424966634654402393B766C5567'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.0.2.1-2.0.2.1_beta_2017-08-01/duplicati-2.0.2.1_beta_2017-08-01-x64.msi' 
$checksum64     = 'B4CEF1C6D4C9FE8E0CE6A84B8D4AB726D56862BAD5D70A5480C5101F9F3AB6CC'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName    = $packageName
  fileType       = $installerType
  url            = $url
  url64bit       = $url64
  validExitCodes = $validExitCodes
  silentArgs     = $silentArgs
  softwareName   = 'Duplicati 2*'
  checksum       = $checksum 
  checksumType   = 'sha256' 
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
