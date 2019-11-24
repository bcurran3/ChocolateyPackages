$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win' 
$checksum      = '9F298283B4659F959C066AD381EF45EFD56C39F3511A69B2C3180F1B5A888412'

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
