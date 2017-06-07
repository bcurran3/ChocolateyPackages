$ErrorActionPreference = 'Stop'
$packageName    = 'winflector'
$softwareName   = 'Winflector*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.winflector.com/store/free-version/index/id/288' 
$checksum       = '7A129FF6BB729550F500F61C40E89D16198D09226AB31DD8F5DA9BFADC73E235'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0, 3010, 1641)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "WinflectorInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
