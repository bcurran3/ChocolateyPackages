$ErrorActionPreference = 'Stop'
$packageName    = 'intel-killer-performance-suite' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = '781426'
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/KillerPerformanceSuite_"+$env:ChocolateyPackageVersion+"_Win10-11x64.exe"
$checksum64     = '39D4E3E8ECCC50C94461C3B4264ACD46F87E95F1D35A8357B25375736252DB0C'

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

Write-Warning "During instalation of the drivers, you will temporarily loose connectivity."
Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update the IntelPackageNumber and checksum64 variables
