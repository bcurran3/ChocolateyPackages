$ErrorActionPreference = 'Stop'
$packageName    = 'active-directory-photos' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.codetwo.com/downloads/C2ADPhotosSetupEN.exe'
$checksum       = 'B9CEC8CE93228887BCEA0D2BC632C9376AA87C06E4EA7B85F75E087F773823C7'
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
