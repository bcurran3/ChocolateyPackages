$ErrorActionPreference = 'Stop'
$packageName    = 'resilio-sync-home'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/Resilio-Sync.exe'
$checksum       = 'ECB3F4E06EE6FAF55264A3DE727FD1C99E7894AB9537B93C3A95BC3FEDF9779B'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/Resilio-Sync_x64.exe'
$checksum64     = 'D5B76BA9FAF198E000F96246CD0B093AD53B4ACCB3B3FE4125DE260D4577A01D'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  url64          = $url64
  validExitCodes = @(0, 1)
  silentArgs     = '/S'
  softwareName   = 'Resilio Sync'
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256' 
  checksumType64 = 'sha256' 
}

Start-CheckandStop "Resilio Sync"
Install-ChocolateyPackage @packageArgs
Start-Sleep -s 5
if ($ProcessWasRunning -eq $False) {Start-CheckandStop "Resilio Sync"}
