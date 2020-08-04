$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows_20200225.exe' 
$checksum       = 'AF29D7B0773E2447170E8697B95C513DB82D15CA71B75FA485022A45EA134E44'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = 'HDHomeRun*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
