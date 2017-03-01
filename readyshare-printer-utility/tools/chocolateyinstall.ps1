$ErrorActionPreference = 'Stop'
$packageName = 'readyshare-printer-utility' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://www.downloads.netgear.com/files/GDC/R6300/ReadySharePrinter_setup_v1.36.zip'
$checksum    = '4C7187D49CD302120EC7EB0A4928E920A57691DBE0651C2862225DBEBF5DDB4A'
$silentArgs  = '/S' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs
  softwareName  = '' 
  }
Install-ChocolateyPackage @packageArgs
