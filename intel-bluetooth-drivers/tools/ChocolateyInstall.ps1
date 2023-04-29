$ErrorActionPreference = 'Stop'
$packageName = 'intel-bluetooth-drivers' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "https://downloadmirror.intel.com/774106/BT-"+$env:ChocolateyPackageVersion+"-32UWD-Win10.exe"
#                                                ^^^^^^ changes
$url64       = "https://downloadmirror.intel.com/774106/BT-"+$env:ChocolateyPackageVersion+"-64UWD-Win10-Win11.exe"
#                                                ^^^^^^ changes
$checksum    = 'B14A37738DFBDC34D2F1FAAD497EB8BC58D37E05A3690067336D8F9BE0B8F1AE'
$checksum64  = 'E83F7BC394B8071C8CB5B3D17631C523DD57FB38D8C9A1C4909DE1DCECDBC06E'

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

Install-ChocolateyPackage @packageArgs
