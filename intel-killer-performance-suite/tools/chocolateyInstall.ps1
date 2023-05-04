$ErrorActionPreference = 'Stop'
$packageName    = 'intel-killer-performance-suite' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = '778012'
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/KillerPerformanceSuite_"+$env:ChocolateyPackageVersion+"_Win10-11x64.exe"
$checksum64     = '1A186F8B75389C35D09BC2431891BB7D67F97FBCAC82F82161B2E8237E9C33C2'

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
