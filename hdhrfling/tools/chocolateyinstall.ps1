$ErrorActionPreference = 'Stop'
$packageName= 'hdhrfling' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://hdhrfling.com/download/hdhrfling_setup_1.2.8.2.exe'
$checksum   = '17184A64379D842FDA020D92B45266443A4AA9BD328AD477126FA3156F0AF3DE'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs
  softwareName  = 'HDHRFling*' 
  }
Install-ChocolateyPackage @packageArgs
