$ErrorActionPreference = 'Stop'
$packageName= 'hdhomerun-view'
$softwareName = 'HDHomeRun*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.silicondust.com/hdhomerun/hdhomerun_windows.exe' 
$silentArgs = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = '09C30860AB4347ED253C984FAAD9889A906C61277027749315EEF5EB6A9D4F28'
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
