$ErrorActionPreference = 'Stop'
$packageName    = 'intel-xtu'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
#$url64          = 'https://downloadmirror.intel.com/29183/XTUSetup.exe'
$url64          = 'https://downloadmirror.intel.com/29183/XTUSetup_7.13.1.5.exe'
$checksum64     = 'A7D8A8D0B3946412AFD642B5B4A01E0133103E0EC0306A3F03C2B35C060E1DFB'

Confirm-WinMinimumBuild 19041

if (Get-IsAMDCPU)
   {
    Write-Warning "Sorry, Intel® Extreme Tuning Utility is NOT for AMD processors." 
    throw
   } 
   
if (Get-IsWinServer)
   {
    Write-Warning "Sorry, Intel® Extreme Tuning Utility is NOT for servers." 
    throw
   }  

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url64          = $url64
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0, 3010)
  softwareName   = 'Intel Extreme Tuning Utility'
  checksum64     = $checksum
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# update the checksum
