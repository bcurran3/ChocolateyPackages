$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win' 
$checksum      = '2C360D02CD254EAFDD4D2C390242532D9BFC8A069E45FD1FA41075887977B486'

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
