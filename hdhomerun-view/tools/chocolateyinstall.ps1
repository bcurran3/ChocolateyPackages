$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows_20180921.exe' 
$checksum       = '4A4E87E4B93299C88424D377E44AF69321F7DD444A6AEEE179132176A3A6076D'

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
