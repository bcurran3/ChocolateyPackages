$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati.portable'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.42-2.0.1.42_canary_2017-01-16/duplicati-2.0.1.42_canary_2017-01-16.zip' 
$checksum      = '4E8A02B8E53AAD0B439F3DB0FBA35CADA003028219EDFC828069012BFC985F02'
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

  
