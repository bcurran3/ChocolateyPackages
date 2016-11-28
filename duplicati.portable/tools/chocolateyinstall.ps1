$ErrorActionPreference = 'Stop'
$packageName   = 'duplicati.portable'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://github.com/duplicati/duplicati/releases/download/v2.0.1.33-2.0.1.33_canary_2016-11-27/duplicati-2.0.1.33_canary_2016-11-27.zip' 
$checksum      = '553646C92A87E469304ECFBC2EE885E258F9B3A4BBC2CFCA7A20D8D6DF8E5C29'
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

  
