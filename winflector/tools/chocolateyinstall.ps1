$ErrorActionPreference = 'Stop'
$packageName= 'winflector'
$softwareName = 'Winflector*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.winflector.com/store/free-version/index/id/272' 
$checksum   = '3BE442D718F5347304E8555BE41703D3A01D49A71B0B567B4DF111B525FE7DFA'
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
