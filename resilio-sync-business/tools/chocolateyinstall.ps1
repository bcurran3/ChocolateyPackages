$packageName    = 'resilio-sync-business'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/cc/2501/Resilio-Sync.exe'
$checksum       = '84256BA87587A50C9FF2D4D4E846729A3B8CF588D41C3BAAB42706EE35065382'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/cc/2501/Resilio-Sync_x64.exe'
$checksum64     = 'C75284DF332DE80E73B24E1E1E885ADCF2276C62D947522D066443DD89D40BE6'
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
