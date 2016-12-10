$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati.portable'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.34-2.0.1.34_canary_2016-12-05/duplicati-2.0.1.34_canary_2016-12-05.zip' 
$checksum      = '185DCE55B4BD9A9EC13C5F83B28FFF5472C044576BBCAAB056745C70D8B19CB6'
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

  
