$packageName    = 'resilio-sync-home'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/Resilio-Sync.exe'
$checksum       = 'CB1B2DC027B40DD307C6667140ACC504D4885CABC05D6DB84A9634A7674188DA'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/Resilio-Sync_x64.exe'
$checksum64     = '283EDE4157D34337B4CBCB3DF79DC17CE97AD58C54AD6B0115AB0311C657F35A'

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
