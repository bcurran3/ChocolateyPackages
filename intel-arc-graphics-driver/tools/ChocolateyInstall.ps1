$ErrorActionPreference = 'Stop'
$packageName = 'intel-arc-graphics-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber ="774229"
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/gfx_win_101.4255.exe"
#                                                                            ^^^^^^^^ changes
$checksum64  = 'A7E58100E583DC58A4EAF13C28A0221E3D80915BF90AEB3CB846386CD688C8F5'

Confirm-WinMinimumBuild 19042
if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "--overwrite --silent --report $toolsDir\install.log"
  softwareName   = ''
  validExitCodes = @(0, 3010, 1641, 14)
   }

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# To updtae this package update the IntelPackageNumber, program version, and checksum variables
