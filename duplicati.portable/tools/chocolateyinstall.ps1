$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati.portable'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.55-2.0.1.55_canary_2017-04-06/duplicati-2.0.1.55_canary_2017-04-06.zip' 
$checksum       = '46CCD83523285B42DE5F92A7DD0B1FEF611D833209141DCA7C64FAA1AE4F007B'
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

  
