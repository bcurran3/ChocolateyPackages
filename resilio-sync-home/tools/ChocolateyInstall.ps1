$packageName    = 'resilio-sync-home'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/Resilio-Sync.exe'
$checksum       = '6A9611FE39371EBBB7905EC1BE9B3DD78709C7D3784DA50641FE2E8A2C130B56'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/Resilio-Sync_x64.exe'
$checksum64     = '0A17263E9E6F09E9D442E7E82EEEB4E0EEE1F02613F134D5EF4F41B3A0C67DE2'
$silentArgs     = '/S'
$validExitCodes = @(0, 1)

Start-CheckandStop "Resilio Sync"

$packageArgs = @{
  packageName    = $packageName
  fileType       = $installerType
  url            = $url
  url64          = $url64
  validExitCodes = $validExitCodes
  silentArgs     = $silentArgs
  softwareName   = 'Resilio Sync'
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256' 
  checksumType64 = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

Start-Sleep -s 5
Start-CheckandStop "Resilio Sync"
#if ($ProcessWasRunning -eq "True") {&$ProcessFullPath} else {Start-CheckandStop "Resilio Sync"}
