$ErrorActionPreference = 'Stop'
$packageName= 'hdhomerun-view'
$softwareName = 'HDHomeRun*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.silicondust.com/hdhomerun/hdhomerun_windows_20161119.exe' 
$checksum   = '61DF64771A6311D0655137D6DA4C6E9393861835258F982EE215E630F6F5AF36'
$silentArgs = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
