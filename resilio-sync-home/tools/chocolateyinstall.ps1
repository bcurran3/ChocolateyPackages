$packageName    = 'resilio-sync-home'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/Resilio-Sync.exe'
$checksum       = '83D388276BA3EFE5F3495D3E02923D598A31D19810E30AE4E9BD5A9B873B0F68'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/Resilio-Sync_x64.exe'
$checksum64     = '1BDD8296699B5B7B3151B7CC8346446DBF300AD6F06B8C93DF6F9B4D70C40819'
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
