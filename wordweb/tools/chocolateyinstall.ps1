$packageName    = 'wordweb-free'
$installerType  = 'exe'
$url            = 'http://uk.wordwebsoftware.com/downloads/wordweb8.exe'
$checksum       = '4105E78F2DFA179E0B4425A9A7D74CF7E9B90EB97F69BC1A7CD4EA341ACACCB7'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$silentArgs     = '/s'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "WWFInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'WordWeb'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
