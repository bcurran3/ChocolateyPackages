$ErrorActionPreference = 'Stop'
$packageName= 'ost2' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://d.4team.biz/files/ost2_setup.exe'
$checksum   = 'CA08D9C2822614FBA2A92DC358FFF2D2DCE67A40C8F235939A7F7AE9DA9C8DC4'
$silentArgs = '/S' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs
  softwareName  = 'OST2*' 
  }
Install-ChocolateyPackage @packageArgs
