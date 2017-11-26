$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$softwareName   = 'HDHomeRun*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.silicondust.com/hdhomerun/hdhomerun_windows_20170930.exe' 
$checksum       = '2EA2E406AD268B7695DBD67E78685361ED2CD83986BD3D2373FBCAA2FA342EEE'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

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
  
