$ErrorActionPreference = 'Stop'
$packageName    = 'readynasvault' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.downloads.netgear.com/files/GDC/R7000/ReadySHAREVault-install-v1.0.50.500.zip'
$checksum       = '26658D4C6CB3C42360305AEE8D00E0FFACA6964BD7D7CE0FE28B37E85E153071'
$installerType  = 'MSI'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'ReadyNASVault'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  