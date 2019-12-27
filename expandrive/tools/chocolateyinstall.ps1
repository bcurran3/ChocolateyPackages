$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win' 
$checksum      = '911ADF97B0DF82B4685BEB10B57A036584ACBC9B394FCED962F0258EF21A4A2D'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = ''
  softwareName  = 'Expandrive*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Start-CheckandStop "ExpanDrive"
Install-ChocolateyPackage @packageArgs
Sleep 5
if ($GLOBAL:ProcessWasRunning -eq $False) {Start-CheckandStop "ExpanDrive"}
# ^ doesn't necessary work in this case
