$ErrorActionPreference = 'Stop'
$packageName    = 'intel-xtu'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url64          = 'https://downloadmirror.intel.com/29183/XTUSetup.exe'
$checksum64     = '762005E092AF832C54D6CA9876939D6969B24CAF2691B6C4A9CB733B3ACB0F9A'

if (Get-IsAMDCPU)
   {
    Write-Warning "Sorry, Intel® Extreme Tuning Utility is NOT AMD processors." 
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
