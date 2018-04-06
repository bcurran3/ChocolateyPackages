$ErrorActionPreference = 'Stop'
$packageName    = 'active-directory-photos' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.codetwo.com/downloads/C2ADPhotosSetupEN.exe'
$checksum       = 'FA8E33F424A1BE4D68A53E9056D740297C3A7BCE4A4D2826A2466693D250EB9F'
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
