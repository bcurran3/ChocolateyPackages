$ErrorActionPreference = 'Stop'
$packageName = 'intel-arc-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = "https://downloadmirror.intel.com/772016/gfx_win_101.4146.exe"
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = 'A736E2285D3979FD8AC74549CDBE4655A7726595EC9B56025E156BDB277C85A0'

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
