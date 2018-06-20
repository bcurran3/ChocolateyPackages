$packageName    = 'resilio-sync-business'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/cc/2501/Resilio-Sync.exe'
$checksum       = 'FDD0FF3E9D2754DC0B4BC772297CA4F2A89A3DB0F86B6B2B7CB49B6A9A25A52D'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/cc/2501/Resilio-Sync_x64.exe'
$checksum64     = 'F7491B35FFCEBD04103CF424CC53822CBCA5F62AF05DCE313743943FA69DC60D'
$silentArgs     = '/S'
$validExitCodes = @(0, 1)

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

