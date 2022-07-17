$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows.exe' 
$checksum       = '7E035682B87218957238B68F3D80FE8E83B5730CCF90AF07921F5BACD3BA1FB3'

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
