$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/29988/a08/igfx_win10_100.8935.exe'
$checksum64  = 'AB73EDDDA92D70F494D03F0372D6452BA47A0D1C5A98D89A51BE2CA4FA285F0C'

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
