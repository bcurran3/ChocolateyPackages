$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati.portable'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.38-2.0.1.38_canary_2016-12-27/duplicati-2.0.1.38_canary_2016-12-27.zip' 
$checksum      = 'BD52AE1A1EA0D72AB4C1826890F48E28C03D9C81CA996FEBBCBA831FA0F11168'
$validExitCodes= @(0)


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

  
