$ErrorActionPreference = 'Stop'
$packageName    = 'intel-killer-performance-suite' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url64          = "https://downloadmirror.intel.com/765127/KillerPerformanceSuite_3"+$env:ChocolateyPackageVersion+"_Win10-11x64.exe"
#                                                   ^^^^^^ changes
$url64          = "https://downloadmirror.intel.com/765127/KillerPerformanceSuite_34.22.1156_Win10-11x64.exe"
$checksum64     = 'CC70A390A12BCA8B5D793AD8B737FA674F216AB7F8AC393BC09003B481605D05'

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
