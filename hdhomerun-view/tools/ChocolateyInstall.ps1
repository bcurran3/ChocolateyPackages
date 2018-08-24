$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows_20180817.exe' 
$checksum       = '073F4DC4974C33605F34154B2E4FA86A9A959B1FE65077B417F49E322DEC5428'

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
  
