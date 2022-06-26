$ErrorActionPreference = 'Stop'
$packageName    = 'intel-killer-performance-suite' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = "https://downloadmirror.intel.com/733325/KillerPerformanceSuite_"+$env:ChocolateyPackageVersion+"_Win10-11x64.exe"
#                                                   ^^^^^^ changes
$checksum64     = 'CCD52C2B7C1179BABE6B83D63CA6ED150A291D7273E1D1489F1055A05CEA9C1F'

Confirm-Win10

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url64          = $url64
  silentArgs     = '/S /v/qn /V/norestart'
  validExitCodes = @(0, 3010, 1641)
  softwareName   = 'Killer Performance Driver Suite UWD'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs
