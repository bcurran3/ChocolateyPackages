$packageName    = 'resilio-sync-business'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://download-cdn.resilio.com/stable/windows/cc/2501/Resilio-Sync.exe'
$checksum       = '95544A33A9C63C1A1B76C024A979ACEBACF440123A4C5FEAAB19377F235A32ED'
$url64          = 'https://download-cdn.resilio.com/stable/windows64/cc/2501/Resilio-Sync_x64.exe'
$checksum64     = '4AA2FE85B8CFEF212A1246CC44A9FBD8725B2F51431827EA05D1E664CC1D8C13'
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
