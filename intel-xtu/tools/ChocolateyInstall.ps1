$ErrorActionPreference = 'Stop'
$packageName    = 'intel-xtu'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url            = 'https://downloadmirror.intel.com/24075/eng/XTUSetup.exe'
$checksum       = 'F856DBC345BDE3ADA5253F7AC0EF2711EDFBB89880B174767F25371FFA668DD4'

if (!(Get-Is64))
   {
    Write-Warning "Sorry, Intel® Extreme Tuning Utility is 64 bit only." 
    throw
   }
   
if (Get-IsWinServer)
   {
    Write-Warning "Sorry, Intel® Extreme Tuning Utility is NOT for servers." 
    throw
   }  

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  silentArgs    = '/quiet /norestart'
  validExitCodes= @(0, 3010)
  softwareName  = 'Intel Extreme Tuning Utility'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
