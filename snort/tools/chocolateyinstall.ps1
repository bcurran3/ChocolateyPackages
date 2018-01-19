$ErrorActionPreference = 'Stop'
$packageName = 'snort' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.snort.org/downloads/snort/Snort_2_9_11_Installer.exe'
$checksum    = '228B88011E1D3E71332DE2F24E33A8BC1C36A621C39BD6116CF95023F3EF4DAD'
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "SnortInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs    = '/S' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }

Install-ChocolateyPackage @packageArgs
