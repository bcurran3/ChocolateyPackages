$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'battle.net'
$url         = 'http://dist.blizzard.com/downloads/bna-installers/322d5bb9ae0318de3d4cde7641c96425/retail.1/Battle.net-Setup-enUS.exe'
$checksum    = '65202C0CD5DFCC18A09243B2761F165CC976F4086EE0EFB6716C709D154BC1BD'

$ahkExe  = 'AutoHotKey'
$ahkFile = "$toolsDir\battlenet-install.ahk"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Battle.net' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = ''
  validExitCodes= ''
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs

Start-WaitandStop "Battle.net"
Start-CheckandStop "AutoHotKey"
