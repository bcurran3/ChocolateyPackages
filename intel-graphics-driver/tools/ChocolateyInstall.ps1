$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/30100/a08/igfx_win10_100.9126.exe'
$checksum64  = '305E8CB44F298699C8C886D6E0136752A82E5B1FCC9AC2A937AEB1AE2457470C'

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
