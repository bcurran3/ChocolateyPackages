$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysArray   = ($env:ChocolateyPackageVersion.split('.'))
$TodaysVersion = $TodaysArray[2] + "." + $TodaysArray[3]
$IntelPackageNumber = '792980'
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/gfx_win_"+"$TodaysVersion"+".exe"
$checksum64  = '07A4B26A5C27ED03FB81CFB19FF5315B7949F125432CB7254C3A0094C8497CC1'

Confirm-WinMinimumBuild 19042
if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }
   
#Write-Host "  ** These drivers are for Intel 11th Gen processors and higher." -Foreground Yellow
#Write-Host "  ** Use intel-graphics-driver for Intel 6th thru 10th Gen processors." -Foreground Yellow

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
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
# To update this package update the IntelPackageNumber and checksum64 variables
