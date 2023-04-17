$ErrorActionPreference = 'Stop'
$packageName        = 'intel-chipset-device-software'
$toolsDir           = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = "774764"
$url                = "https://downloadmirror.intel.com/$IntelPackageNumber/SetupChipset.exe"
$checksum           = '3BA66C0A2D2DBA5905FEF3EF8FC5CE82B9D5B781A9F693333C5B7476428CA0FD'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0,1,3010)
  silentArgs     = '-s -norestart -downgrade'
  softwareName   = 'Intel(R) Chipset Device Software'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update IntelPackageNumber and checksum variables
