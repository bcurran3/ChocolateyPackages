$ErrorActionPreference = 'Stop'
$packageName    = 'readyshare-vault' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.downloads.netgear.com/files/GDC/R7000/ReadySHAREVault-install-v1.0.50.500.zip'
$checksum       = '26658D4C6CB3C42360305AEE8D00E0FFACA6964BD7D7CE0FE28B37E85E153071'
$silentArgs     = '/S' 
$validExitCodes = @(0)
$fileLocation   = Join-Path $toolsDir "ReadySHAREVault-install.exe"
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "RSVaultInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'ReadySHARE Vault'
}
 
Install-ChocolateyInstallPackage @packageArgs