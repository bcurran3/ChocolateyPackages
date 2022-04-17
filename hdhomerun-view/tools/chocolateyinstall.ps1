$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$url            = 'https://download.silicondust.com/hdhomerun/hdhomerun_windows.exe' 
$checksum       = '019899BE6765C4B0E668D2C8CAE59827152E7999864EB12E8394E62535C5C14F'

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
