$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win'
$checksum      = '0BFAEE5A887030BC52EFAF40AEC727ACE5C57BAEEB0D23ACF180CED5F089E954'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = ''
  softwareName   = 'Expandrive*'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Start-CheckandStop "ExpanDrive"
Install-ChocolateyPackage @packageArgs
if ($ProcessWasRunning -eq $False) {Start-WaitandStop "ExpanDrive"}
if ($ProcessWasRunning -eq $False) {Start-WaitandStop "ExpanDrive"}
