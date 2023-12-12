$ErrorActionPreference = 'Stop'
$packageName    = 'intel-killer-performance-suite' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = '794919'
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/KillerPerformanceSuite_"+$env:ChocolateyPackageVersion+"_Win10-11_x64.exe"
$checksum64     = 'D4FED4EEE4CCAAD97C5E80CADC477ACF34451DEDC1B64456AA71B4E16DFBA603'

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
