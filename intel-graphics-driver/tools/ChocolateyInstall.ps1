$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/738230/gfx_win_101.3222_101.2111.exe'
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = '7C3670C7FE9E37C1471D28D2C72C2EE181A71CC2C35BD2F49DDC4B1F514B9C31'

if (!(Get-IsWin10)){
    Write-Warning "  ** This version is only for Windows 10 & 11."
    throw
   }

if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "--overwrite --silent --report $toolsDir\install.log"
  softwareName   = ''
  validExitCodes = @(0, 3010, 1641, 14)
   }

Install-ChocolateyPackage @packageArgs
