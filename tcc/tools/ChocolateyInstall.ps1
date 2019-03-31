$ErrorActionPreference = 'Stop'
$packageName = 'tcc'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v24/tcc.exe'
$checksum    = '89AC7B69E0B07061D2784B99F00E75DCFFBDA803B3A72C25C7E80A634E7515BF'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  silentArgs    = '/quiet'
  softwareName  = 'TCC 24' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
