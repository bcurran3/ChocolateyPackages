$packageName = 'tcc'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v24/tcc.exe'
$checksum    = 'BC330C00F1AF9CF2B1D5295731B81076288D427BBA876A50544E3DC92E3EDE3A'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  silentArgs    = '/quiet'
  softwareName  = 'TCC 24' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
