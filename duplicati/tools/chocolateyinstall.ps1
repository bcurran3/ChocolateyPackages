$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.72-2.0.1.72_canary_2017-07-05/duplicati-2.0.1.72_canary_2017-07-05-x86.msi' 
$checksum       = '428C795A82362AFAB6A4843A50CB0C289692C828BD3BAF6C6C639B053C2976D8'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.72-2.0.1.72_canary_2017-07-05/duplicati-2.0.1.72_canary_2017-07-05-x64.msi' 
$checksum64     = '18696C1CD18BEF4FCA50432D745E7FB8EF90BD24E43FD81040B9E2FFA9E97C00'
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
  
