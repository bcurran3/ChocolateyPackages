$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$url            = 'http://download.silicondust.com/hdhomerun/hdhomerun_windows_20200907.exe' 
$checksum       = '89BA8782090851A14EF9E94900993A65CAAB975DF72AB3AB104B0A8E3E2EB253'

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
