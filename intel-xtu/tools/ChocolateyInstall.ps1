$ErrorActionPreference = 'Stop'
$packageName    = 'intel-xtu'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url64          = 'https://downloadmirror.intel.com/29183/XTUSetup.exe'
#                  ^^^^ consistent link
$checksum64     = '4369E40251C81BE064EC163DF65516E9CD8D76646FF8BEA2C25E830FDD18FF06'

Confirm-WinMinimumBuild 18362

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