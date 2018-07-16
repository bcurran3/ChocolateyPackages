$packageName    = 'wordweb-free'
$installerType  = 'exe'
$url            = 'https://wordweb.info/cgi-bin/geoip/wordweb.exe'
$checksum       = '8BCE6993A4D28AE72D9D09B84C34A373326C799224FE1E601F088DE4B1CBF370'
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
