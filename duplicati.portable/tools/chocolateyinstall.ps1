$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati.portable'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.72-2.0.1.72_canary_2017-07-05/duplicati-2.0.1.72_canary_2017-07-05.zip' 
$checksum       = 'E0727939494F55DFA7FB36350C06FD5BA5896AFFAE91716CBF9BE33098B3E8E2'
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

  
