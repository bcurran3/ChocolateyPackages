$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysArray   = ($env:ChocolateyPackageVersion.split('.'))
$TodaysVersion = $TodaysArray[2] + "." + $TodaysArray[3]
$IntelPackageNumber = '788440'
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/gfx_win_"+"$TodaysVersion"+".exe"
$checksum64  = '2F2809DAE8AF8F99756F23311A057EE7A71F6B46AB3FFDF053CF8EC3BA5451DC'

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
# To update this package update the IntelPackageNumber and checksum64 variables
