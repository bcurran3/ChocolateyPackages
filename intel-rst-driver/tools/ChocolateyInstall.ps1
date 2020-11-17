$ErrorActionPreference = 'Stop'
$packageName = 'intel-rst-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloadmirror.intel.com/29978/eng/SetupRST.exe'
$checksum    = '4307EEF4789AA4977182150A6866310E4A76ACBB6D5D369C93E7E77FF0E3CC9A'

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
