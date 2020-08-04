$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-recovery-console'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x86.exe'
$checksum       = 'C6922C9B89BB982D1A762D8CA38C4E26FA208C1EA9F8172941A498DE5EF40026'
$url64          = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x64.exe'
$checksum64     = '79AFDC614A11F453E71771D1AC781520A1A305BC8CAE9D9C47F7FED1FEB50A98'

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
