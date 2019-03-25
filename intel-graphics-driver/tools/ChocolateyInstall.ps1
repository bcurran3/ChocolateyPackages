$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/28567/a08/dch_win64_25.20.100.6577.exe'
$checksum64  = 'FAE0769994067E99A0EFD0F55C17A4177EE06D3C0626C41BE878FE830A22EE7D'
$ahkExe      = 'AutoHotKey'
$ahkFile     = "$toolsDir\intel-graphics-driver_install.ahk"

if (!(Get-IsWin10)){
    Write-Warning "  ** This version is only for Windows 10."
    throw
   }

if (!(Get-Is64)){
   Write-Warning "  ** This version is only for 64 bit OSes."
   throw
  }

if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = ''
  checksum      = ''
  checksumType  = ''  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = ''
  softwareName  = 'Intel® Graphics Driver'
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
