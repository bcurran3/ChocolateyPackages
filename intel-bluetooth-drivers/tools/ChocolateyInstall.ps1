$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = "https://downloadmirror.intel.com/768309/BT-"+$env:ChocolateyPackageVersion+"-32-64UWD-Win10-Win11.exe"
#                                                ^^^^^^ changes
$checksum64  = 'B14A37738DFBDC34D2F1FAAD497EB8BC58D37E05A3690067336D8F9BE0B8F1AE'

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
