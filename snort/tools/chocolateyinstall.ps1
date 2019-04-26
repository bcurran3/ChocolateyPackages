$ErrorActionPreference = 'Stop'
$packageName = 'snort' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://www.snort.org/downloads/snort/Snort_2_9_13_Installer.exe'
$checksum    = '6F5A5E1A69D218D19025BAB8A1BFE1FF86B06438C27DBC9DAFBEB3AF8AA797CB'
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\SnortInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = '/S' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }

Install-ChocolateyPackage @packageArgs
