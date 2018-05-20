$packageName    = 'wordweb-free'
$installerType  = 'exe'
$url            = 'https://uk.wordwebsoftware.com/downloads/wordweb8.exe'
$checksum       = '33A3D3DF7A9BE2D30D69C2B2CB8385D92AE2AC3DDB1556CE23BC2342CD131BF5'
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
