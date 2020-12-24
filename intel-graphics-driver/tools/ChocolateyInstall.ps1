$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/30079/a08/igfx_win10_100.9079.exe'
$checksum64  = 'E1EAD2C04E78311309ABBA72DF6CAA2943F3F816EE66D06ABA59501641C87CA9'

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
