$ErrorActionPreference = 'Stop'
$packageName    = 'active-directory-photos' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.codetwo.com/downloads/C2ADPhotosSetupEN.exe'
$checksum       = '2679AE59BFC014E4C9AA8046BA11D3F7E5CEF36536A4BE768BF5DE4606DD392E'
$silentArgs     = ''
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "C2ADInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
  silentArgs    = $silentArgs
  softwareName  = 'CodeTwo Active Directory Photos*' 
  validExitCodes= $validExitCodes
  }
  
Install-ChocolateyPackage @packageArgs
