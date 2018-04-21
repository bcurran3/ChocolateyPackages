$ErrorActionPreference = 'Stop'
$packageName    = 'winflector'
$softwareName   = 'Winflector*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winflector.com/store/free-version/index/id/348' 
$checksum       = '07528DB13B760EE9C41ACC912F05AFCE072F370A8B7211380AD06018459F0B1E'
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
