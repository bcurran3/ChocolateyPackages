$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/738230/gfx_win_101.3222_101.2111.exe'
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = '575D3C957BA0FD3847A73C77A63031448283272185AAA7AD5F73DF21D709ABA1'

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
