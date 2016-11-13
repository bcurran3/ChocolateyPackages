$ErrorActionPreference = 'Stop'
$packageName= 'winflector'
$softwareName = 'Winflector*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.winflector.com/store/free-version/index/id/250' 
$checksum   = '0C2CFDC7B43DC17AA2582F8A624A23BF52BD12980684606DA32CD86DE330AECF'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes= @(0, 3010, 1641)
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "WinflectorInstall.ahk"
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
