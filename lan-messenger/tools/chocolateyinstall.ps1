$ErrorActionPreference = 'Stop'
$packageName = 'lan-messenger' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://github.com/lanmessenger/lanmessenger/releases/download/v1.2.37/lmc-1.2.37-win32.exe'
$checksum    = '4E2170F960CADA658C9F0417E071CDB03251BC294AACEC25C92939531597091B'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs    = '/S' 
  softwareName  = 'LAN Messenger*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
