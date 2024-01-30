$ErrorActionPreference = 'Stop'
$packageName = 'intel-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url64       = "https://downloadmirror.intel.com/751359/gfx_win_"+$env:ChocolateyPackageVersion+".exe"
$url64       = "https://downloadmirror.intel.com/751359/gfx_win_101.3790_101.2114.exe"
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = 'C5A85A81DDC49DE07090C4DB044F07328AC6CC62FEBD56F205871331C147E27D'

Confirm-Win10
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
