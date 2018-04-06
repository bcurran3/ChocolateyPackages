$ErrorActionPreference = 'Stop'
$packageName = 'snort' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.snort.org/downloads/snort/Snort_2_9_11_1_Installer.exe'
$checksum    = '8650BCB1CAF20B1416E3E50DEBABEEF5875C691D19F402E04DB0A6C5E2C932D5'
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
