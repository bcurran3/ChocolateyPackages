$packageName    = 'intel-driver-update-utility'
$installerType  = 'exe'
$url            = 'https://downloadmirror.intel.com/24345/a08/Intel%20Driver%20Update%20Utility%20Installer.exe'
$checksum       = 'F94090EE64D2F8A9BE2D21BFA3430EC7823B4C6B1D5B6287429F754CB5DB6044'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$silentArgs     = '/q /norestart'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "DUUinstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Intel® Driver Update Utility*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
