$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$IntelPackageNumber ="784628"
$url            = "https://downloadmirror.intel.com/784628/WiFi-22.160.0-Driver32-Win10.exe"
$checksum       = '64F1B31AFD8F842B887C99575494EBE16BB21AFC582688008344A4FA0A3A94DE'
$url64          = "https://downloadmirror.intel.com/$IntelPackageNumber/WiFi-"+$ENV:ChocolateyPackageVersion+"-Driver64-Win10-Win11.exe"
$checksum64     = '565FFF61AA1D3A3357778779ED4D21763DC4536CE9240AC3E876A7E086927E5D'

# Last Windows 7+8 version was 21.40.5
# Last Windows 10 32-bit version was 22.160.0
# No need to check for hardware, drivers install even if an Intel PROSet/Wireless card is not found

Confirm-Win10

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '-silent'
  softwareName   = ''  
}

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# To updtae this package update the IntelPackNumber and checksum variables