$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/737033/BT-22.150.0-32-64UWD-Win10-Win11.exe'
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = '01BAAE8CD6CBDA906FD1A9933A7518F141BEDDD0628EFC7E986EE3A7136C7291'

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
