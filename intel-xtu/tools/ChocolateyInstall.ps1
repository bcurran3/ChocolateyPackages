$ErrorActionPreference = 'Stop'
$packageName    = 'intel-xtu'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url64          = 'https://downloadmirror.intel.com/29183/XTUSetup.exe'
$checksum64     = '25C4345E795D65D2612FF59340A21FF583CCB9805D225545CCBBE25C9E738607'

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
