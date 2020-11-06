$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win' 
$checksum      = '640EDD703AE800582661D44C2713D5278AFA262B167824CD33C86B3050E3602B'

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
