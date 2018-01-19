$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$softwareName   = 'HDHomeRun*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.silicondust.com/hdhomerun/hdhomerun_windows_20171221.exe' 
$checksum       = 'DF4F637AF14A4401597EF9593B5F8FC37C921149616483849656369FFD9AC32F'
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
  
