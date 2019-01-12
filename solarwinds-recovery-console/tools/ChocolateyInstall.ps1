$packageName    = 'solarwinds-recovery-console'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x86.exe'
$checksum       = 'E5F9501A729DEC392A6CFBD7C94E9C6078D231278B70D4F9E25C70E1216566B8'
$url64          = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x64.exe'
$checksum64     = 'D9E52441CB6DE5022BFD93829B74B1D30AF1AD5DAC6896B48874A4FB252C445B'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64          = $url64
  validExitCodes = @(0,1)
  silentArgs     = '/S'
  softwareName   = 'Recovery Console'
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs

Start-CheckandStop "ProcessController"
Start-CheckandStop "RecoveryConsole"
