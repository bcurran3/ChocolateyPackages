$ErrorActionPreference = 'Stop'
$packageName= 'tonic' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.r2.com.au/static/downloads/files/tonic-v1.0b990.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/S' 
  softwareName  = 'Tonic*' 
  checksum      = '0A3745A36182BF8279158BAC5A56AAB3E778D161C3DCC76B1B92A68D8219D9D8'
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
