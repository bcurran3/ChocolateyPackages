$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = '777669'
$url         = "https://downloadmirror.intel.com/$IntelPackageNumber/BT-"+$env:ChocolateyPackageVersion+"-32UWD-Win10.exe"
$checksum    = 'B14A37738DFBDC34D2F1FAAD497EB8BC58D37E05A3690067336D8F9BE0B8F1AE'
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/BT-"+$env:ChocolateyPackageVersion+"-64UWD-Win10-Win11.exe"
$checksum64  = 'CADE1C5298DDCF3D65F2C10AC309D6C54B8AE40A1C5FC9D088BF5CEC60C1EB01'

Confirm-Win10

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url  
  url64bit       = $url64
  checksum       = $checksum
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
