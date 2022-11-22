$ErrorActionPreference = 'Stop'
$packageName    = 'intel-killer-performance-suite' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url64          = "https://downloadmirror.intel.com/758526/KillerPerformanceSuite_3"+$env:ChocolateyPackageVersion+"_Win10-11x64.exe"
#                                                   ^^^^^^ changes
$url64          = "https://downloadmirror.intel.com/758526/KillerPerformanceSuite_33.22.1142_Win10-11x64.exe"
$checksum64     = '3E9EED96488F3AB251B667C16D04D70E349FB109FD837A93EF1DFCDE42E6DBB1'

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
