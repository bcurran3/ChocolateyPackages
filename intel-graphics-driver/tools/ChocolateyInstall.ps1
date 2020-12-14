$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/30066/a08/igfx_win10_100.9030.exe'
$checksum64  = 'FCEFD5531E8F5EEBF38E72762D17B09BB45A3BC6725F003126927A02AC386903'

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
