$ErrorActionPreference = 'Stop'
$packageName= 'winflector'
$softwareName = 'Winflector*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.winflector.com/store/free-version/index/id/264' 
$checksum   = '59BD7C509653B189B117C818126AA60DCC21F09A68F706DDE263CCD369FAE707'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes= @(0, 3010, 1641)
$ahkExe     = 'AutoHotKey'
$ahkFile    = Join-Path $toolsDir "WinflectorInstall.ahk"

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
