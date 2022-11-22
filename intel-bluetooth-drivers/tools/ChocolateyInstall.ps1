$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/757403/BT-22.180.0-32-64UWD-Win10-Win11.exe'
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = '4E4F9CB5464BF382915974CEF0BE9D7A27C81EAC2E47C97AE6C39D0EB29D5C1F'

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
