$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloadmirror.intel.com/774106/BT-22.210.0-64UWD-Win10-Win11.exe'
#                                                ^^^^^^ changes  ^^^^^^^^
$checksum64  = 'E6B19394C1AFE787AD2347AA842C5E2CACEF6508'

Confirm-Win10

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha1'
  silentArgs     = "/quiet /norestart"
  softwareName   = ''
  validExitCodes = @(0, 3010, 1641, 14)
   }

Install-ChocolateyPackage @packageArgs
