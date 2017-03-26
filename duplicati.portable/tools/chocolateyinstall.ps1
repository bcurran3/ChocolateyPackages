$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati.portable'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.53-2.0.1.53_experimental_2017-03-13/duplicati-2.0.1.53_experimental_2017-03-13.zip' 
$checksum       = 'DE719E3E90857789676B8F9B97324A48E70001EC48303BC055DBE35C2B71482D'
$validExitCodes = @(0)


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

  
