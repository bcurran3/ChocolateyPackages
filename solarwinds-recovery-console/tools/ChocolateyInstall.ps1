$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-recovery-console'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x86.exe'
$checksum       = '89ED88CE6834005D0EF41D14C2E2C86A4796DC6BE79382BCBA2A76BC5170A0E5'
$url64          = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x64.exe'
$checksum64     = '4ADC867826C9A60888D7697E08534F12D86CDEA27BAF945B363AE2B15F524A75'

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
