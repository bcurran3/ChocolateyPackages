$packageName    = 'resilio-sync-home'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/cc/2501/Resilio-Sync.exe'
$checksum       = '6E3E70B6526C94761705A45580ECD62D41859D1405C51FC28F01CA4AE8949D3F'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/cc/2501/Resilio-Sync_x64.exe'
$checksum64     = 'B9593A61CA46079BEB542DFF4A58515A9AA3FBFB7AF8F7E16D9BD6A21487EC7A'
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
  
if((get-process "Resilio Sync" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "Resilio Sync currently NOT running." 
  }else{ 
    Write-Host "Stopping Resilio Sync process..."
    Stop-Process -processname "Resilio Sync"
	}
