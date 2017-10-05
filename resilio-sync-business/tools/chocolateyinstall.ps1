$packageName    = 'resilio-sync-business'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/cc/2501/Resilio-Sync.exe'
$checksum       = 'FB8197C8609D22B31E34D9AE29B340BC1A50FAEECBC4A8CD353BEEA9DAFD1076'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/cc/2501/Resilio-Sync_x64.exe'
$checksum64     = 'A59F37A4BB78D7BEBE44174E5D5DDEF01F98317B10C6733165D3E259AB046797'
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
