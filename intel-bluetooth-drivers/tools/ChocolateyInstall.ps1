$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = '787935'
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/BT-"+$env:ChocolateyPackageVersion+"-64UWD-Win10-Win11.exe"
$checksum64  = 'DEC8D2CC209140398BF1D7CA430B7EE1A5CBBD992F622F17A08DAC6EAC23857A'

Confirm-Win10

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "/quiet /norestart"
  softwareName   = ''
  validExitCodes = @(0, 3010, 1641, 14)
   }

Write-Warning "During instalation of the drivers, Bluetooth peripherals will temporarily be unavailable."
Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update the IntelPackageNumber and checksum variables
