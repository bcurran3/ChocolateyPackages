$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/Resilio-Sync.exe'
$checksum       = '7EEE3CBE810B1F24ECF0A715A7DCAA5470645245578A522050018681F91592D7'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/Resilio-Sync_x64.exe'
$checksum64     = '3D56C697B896BE3E2722DA3AC12C9002859AC7F6814936602BDDD68AA88F796B'
$packageArgs = @{
  packageName    = 'resilio-sync-home'
  fileType       = 'exe'
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
Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Show-ToastMessage "Resilio Sync Home installed." "Version $env:packageVersion."
Start-Sleep -s 5
if ($ProcessWasRunning -ne "True") {Start-CheckandStop "Resilio Sync"}
