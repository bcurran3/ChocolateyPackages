$ErrorActionPreference = 'Stop'
$packageName    = 'intel-xtu'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url64          = 'https://downloadmirror.intel.com/29183/XTUSetup.exe'
$checksum64     = 'D6E95DC3A662EEBD80C0D5D16263673A61FEF9564FDEBCAD059389261DB2529E'

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

# if error 1
# Having Core Isolation Memory Integrity (HVCI), Hyper-V, or Virtual Machine System features enabled - are incompatible.

# UPDATE INSTRUCTIONS:
# update the checksum
