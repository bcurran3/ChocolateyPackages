$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$softwareName   = 'HDHomeRun*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.silicondust.com/hdhomerun/hdhomerun_windows_20180418.exe' 
$checksum       = '6CE0467211FFEAC6D9E1D462FB2808D910533135BB4433C9105DE80202B54EFE'
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
  
