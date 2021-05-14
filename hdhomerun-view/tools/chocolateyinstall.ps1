$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$url            = 'http://download.silicondust.com/hdhomerun/hdhomerun_windows_20210301.exe' 
$checksum       = '9AE106C78E48AC2DBEBAA9374C03307BBA8620FFDB5ED060623F1402031F5C55'

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
