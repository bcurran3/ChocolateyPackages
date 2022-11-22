$ErrorActionPreference = 'Stop'
$packageName = 'intel-arc-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = "https://downloadmirror.intel.com/758772/gfx_win_101.3802.exe"
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = 'AEE451813B6DE6162C28F995E7ACA2808271D979BED49A1F38F778784CE395C5'

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
  silentArgs     = "--overwrite --silent --norestart --report $toolsDir\install.log"
  softwareName   = ''
  validExitCodes = @(0, 3010, 1641, 14)
   }

Install-ChocolateyPackage @packageArgs
