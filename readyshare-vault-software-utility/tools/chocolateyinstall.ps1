$ErrorActionPreference = 'Stop'
$packageName = 'readyshare-vault-software-utility' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://www.downloads.netgear.com/files/GDC/R7000/ReadySHAREVault-install-v1.0.50.500.zip'
$checksum    = '26658D4C6CB3C42360305AEE8D00E0FFACA6964BD7D7CE0FE28B37E85E153071'
$silentArgs  = '/S' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs
  softwareName  = 'ReadyCLOUD' 
  }
Install-ChocolateyPackage @packageArgs
