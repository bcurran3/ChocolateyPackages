$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$url           = 'https://secure.expandrive.com/expandrive/download_win'
$checksum      = '1E3DBF62D8C3DF6E2679DD46D91C1C5D3A56653BFDD534340202A2C66EDE0C7D'

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
