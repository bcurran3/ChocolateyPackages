$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$TodaysArray   = ($env:ChocolateyPackageVersion.split('.'))
$TodaysVersion = $TodaysArray[2] + "." + $TodaysArray[3]
$IntelPackageNumber = '791578'
$url64       = "https://downloadmirror.intel.com/$IntelPackageNumber/gfx_win_"+"$TodaysVersion"+".exe"
$checksum64  = '11E35C18C7B0568BE46063E7FA6844F1B7BA48548791402F6AA17132401305D1'

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
