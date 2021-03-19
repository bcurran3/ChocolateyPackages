$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/30266/a08/igfx_win10_100.9316.exe'
$checksum64  = '05E027D0B54AE158A6E8066CFB026C64994B573B13D74AA6F7352E07DCC953FB'

if (!(Get-IsWin10)){
    Write-Warning "  ** This version is only for Windows 10."
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
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = "-overwrite -s -report $toolsDir\install.log"
  softwareName  = ''
  }

Install-ChocolateyPackage @packageArgs
