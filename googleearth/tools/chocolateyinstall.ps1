$ErrorActionPreference = 'Stop'
$packageName   = 'googleearth'
$installerType = 'EXE'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://dl.google.com/earth/client/GE7/release_7_1_7/googleearth-win-bundle-7.1.7.2602.exe' 
$checksum      = '677483CCCC9C905C982821B9C997C38A9BF6D266FD14048F9CB0A80BAC239B04'
$silentArgs    = ''
$validExitCodes= @(0)
$ahkExe        = 'AutoHotKey'
$ahkFile       = Join-Path $toolsDir "GoogleEarthInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Google Earth*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs 
  
