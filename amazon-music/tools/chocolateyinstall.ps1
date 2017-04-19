$ErrorActionPreference = 'Stop'
$packageName    = 'amazon-music'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://images-na.ssl-images-amazon.com/images/G/01/digital/music/morpho/installers/20170111/083554d100/AmazonMusicInstaller.exe' 
$checksum       = 'E7154D87AD55E2DB4EBC0B134D7E028E9E547F6B1669DD0A69076335DDD7ACD7'
$silentArgs     = ''
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "AMInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Amazon Music' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Write-Host "It's normal to get warnings after the install is finished." -foreground "magenta" –backgroundcolor "blue"
Install-ChocolateyPackage @packageArgs 
