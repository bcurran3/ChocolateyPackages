$packageName    = 'resilio-sync-home'
$version        = '2.6.4'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "https://download-cdn.resilio.com/$version/windows/Resilio-Sync.exe"
$checksum       = 'D8B12A6455B4FD9C1C98E892E1204A8EFF7A924C2EC6DDB2B3A664AC15F313AF'
$url64          = "https://download-cdn.resilio.com/$version/windows/Resilio-Sync_x64.exe"
$checksum64     = 'C46B4C00EA7CEE5168E791096834426F31FDD46E960C1A42D97A6FAD3FB4AC1D'

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
