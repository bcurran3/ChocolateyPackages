$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati.portable'
$installerType = 'zip'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'http://updates.duplicati.com/experimental/duplicati-2.0.1.30_experimental_2016-11-03.zip' 
$checksum      = '6822850407C48511E879DFD546EA73F6534A42BFAD1675D8F16DF8D07059B1D7'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Duplicati 2*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs  
  
