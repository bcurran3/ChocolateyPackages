$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = "https://downloadmirror.intel.com/763703/BT-"+$env:ChocolateyPackageVersion+"-32-64UWD-Win10-Win11.exe"
#                                                ^^^^^^ changes
$checksum64  = 'A410D204901B669ECE90876CB6DF8D8B5137726D741703F1CF03166F82C0A7D9'

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

Install-ChocolateyPackage @packageArgs
