$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win'
$checksum      = 'E034D629802DA756163B5B79DE3F7F0C88D1700C19B804989C56E9C68F579B32'

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
