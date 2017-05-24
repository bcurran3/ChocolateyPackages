$packageName    = 'wordweb-free'
$installerType  = 'exe'
$url            = 'http://uk.wordwebsoftware.com/downloads/wordweb8.exe'
$checksum       = 'BD93E4F745B65C9FE395FC646B26E835D10A6EA7063DEC14DD7B188D32AE3C53'
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
