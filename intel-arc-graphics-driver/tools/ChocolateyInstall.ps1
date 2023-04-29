$ErrorActionPreference = 'Stop'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$IntelPackageNumber = "777403"
$TodaysArray   = ($env:ChocolateyPackageVersion.split('.'))
$TodaysVersion = $TodaysArray[2] + "." + $TodaysArray[3]
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/gfx_win_"+"$TodaysVersion"+".exe"
$checksum64  = '6DD2026DB396393126FB352018442A7728D8D5A4DAF7DA29DB2B9F14D7A55D9E'

Confirm-WinMinimumBuild 19042
if (!(Get-IsIntelVideo)){
    Write-Warning "  ** No Intel display adapter found."
    throw
   }

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
# To updtae this package update the IntelPackageNumber, and checksum variables
