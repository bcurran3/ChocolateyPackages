$ErrorActionPreference = 'Stop'
$packageName    = 'solarwinds-recovery-console'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x86.exe'
$checksum       = '39581CCF4C8C074E455727D9D8BBAED79A81024340FE4FE926EC363328B0FC69'
$url64          = 'https://install.mob.system-monitor.com/backup-and-recovery-rc-windows-x64.exe'
$checksum64     = '122D66B30BD262449557B21074560DB02EEB64315164726052615BE8742559FF'

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
