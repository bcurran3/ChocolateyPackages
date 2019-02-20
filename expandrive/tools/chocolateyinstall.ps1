$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win' 
$checksum      = '313911494D303BD530CBE8C1ADA145D562B8B60A6368908D0B846DB410432DFD'

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
