$ErrorActionPreference = 'Stop'
$packageName    = 'active-directory-photos' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.codetwo.com/downloads/C2ADPhotosSetupEN.exe'
$checksum       = 'D1CEE7EB2B2EA8A9B82823CB7D8F3650D0D2830B1D43B25A496264802ED0396D'
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
