$ErrorActionPreference = 'Stop'
$packageName = 'intel-arc-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = "https://downloadmirror.intel.com/762922/gfx_win_101.3959.exe"
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = '40824A6F1EE5DE30D9603438931A3A0B7A4F346F0E361AF077975AA8A8F4EDEF'

Confirm-WinMinimumBuild 19042
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
