$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysArray   = ($env:ChocolateyPackageVersion.split('.'))
$TodaysVersion = $TodaysArray[2] + "." + $TodaysArray[3]
$IntelPackageNumber = '812114'
#$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/gfx_win_"+"$TodaysVersion"+".exe"
$url64       = "https://downloadmirror.intel.com/812114/gfx_win_101.5084_101.5122.exe"
$checksum64  = '414390B649D9DEF62E5F7C6DDEB2C7AD3B504171B1D7133D812D6578668120BE'

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
