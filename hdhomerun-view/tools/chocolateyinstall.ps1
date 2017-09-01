$ErrorActionPreference = 'Stop'
$packageName    = 'hdhomerun-view'
$softwareName   = 'HDHomeRun*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.silicondust.com/hdhomerun/hdhomerun_windows_20170815.exe' 
$checksum       = '2ECDEE81737EBCF0B169297E11233FC070AAF9B0628AAB7C444BABA183B44F06'
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
  
