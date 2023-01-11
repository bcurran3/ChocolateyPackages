$ErrorActionPreference = 'Stop'
$packageName    = 'intel-proset-drivers' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$url            = "https://downloadmirror.intel.com/763754/WiFi-"+$ENV:ChocolateyPackageVersion+"-Driver32_Win10.exe"
#                                                   ^^^^^^ changes
$checksum       = '64F1B31AFD8F842B887C99575494EBE16BB21AFC582688008344A4FA0A3A94DE'
$url64          = "https://downloadmirror.intel.com/763754/WiFi-"+$ENV:ChocolateyPackageVersion+"-Driver64-Win10-Win11.exe"
#                                                   ^^^^^^ changes
$checksum64     = '9A6B36994D3FD2B2A869FEFD0DAFBB41A3D99E06BAE23392DBD0AF05D844AF81'

# Last Windows 7+8 version was 21.40.5
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
