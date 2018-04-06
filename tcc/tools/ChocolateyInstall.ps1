$packageName = 'tcc'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileType    = 'exe'
$silentArgs  = '/quiet'
$url         = 'https://jpsoft.com/downloads/v22/tcc.exe'
$checksum    = '195072FD6D093717D8D053B4B24D49814028CD6585E773965BB1006238C80E13'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $fileType 
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'TCC 22' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs