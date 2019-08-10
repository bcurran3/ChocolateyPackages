$ErrorActionPreference = 'Stop'
$packageName = 'intel-rst-driver' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloadmirror.intel.com/28966/eng/SetupRST.exe'
$checksum    = 'B08C51DEC8D3298B4B87BB5009894C393A02B7F64734D1C519792558C91081B9'

if ((Get-IsWin10 -eq $false) -and (Get-IsWinServer2016 -eq $false)){
   Write-Warning "  ** This version is Windows 10 and Windows Server 2016 only."
   throw
}

if (Get-PendingReboot -eq $true){
   Write-Warning "  ** There is a pending reboot. Please reboot and try again."
   throw
}

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'  
  silentArgs     = '-s' 
  softwareName   = 'Intel(R) Rapid Storage Technology' 
  validExitCodes = @(0, 3010, 1641)
  }

Install-ChocolateyPackage @packageArgs
