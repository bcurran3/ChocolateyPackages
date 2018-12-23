$packageName    = 'resilio-sync-business'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/cc/2501/Resilio-Sync.exe'
$checksum       = '6E9FB31BB1EB4D29BC06B27E2F137371B83C4C5FA4263C28CDAE31EE0BFD0ADE'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/cc/2501/Resilio-Sync_x64.exe'
$checksum64     = '4441E71C4390EB5F9F4D0E48483493CEC8E3B86BDEADBACA5ABEE70F803F5B25'

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
