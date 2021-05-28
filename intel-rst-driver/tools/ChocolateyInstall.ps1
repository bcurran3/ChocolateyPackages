$ErrorActionPreference = 'Stop'
$packageName = 'intel-rst-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloadmirror.intel.com/30314/eng/SetupRST.exe'
#                                                ^^^^^ is what changes with the version
$checksum    = 'E3C7BDAEA88511920CFD16B42DC7DF75F53476F4CC6CB11DAB2B73CCFF8481A9'

if ((Get-IsWin10 -eq $false) -and (Get-IsWinServer2016 -eq $false)){
   Write-Warning "  ** This version is Windows 10 and Windows Server 2016 only."
   throw
}

#if (Get-PendingReboot -eq $true){
#   Write-Warning "  ** There is a pending reboot. Please reboot and try again."
#   throw
#}

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'  
  silentArgs     = '-s /acceptEULA' 
  softwareName   = 'Intel(R) Rapid Storage Technology' 
  validExitCodes = @(0, 3010, 1641)
  }

Install-ChocolateyPackage @packageArgs
