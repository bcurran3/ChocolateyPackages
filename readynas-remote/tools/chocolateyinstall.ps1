$ErrorActionPreference = 'Stop'
$packageName = 'readynas-remote' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://remote.readynas.com/ReadyNASRemoteSetup.exe'
$checksum    = '81952B2568A0C21254D39DC4FF07AF4F00010DEDA8CA959505E30D28DE7CD13C'
$silentArgs  = '/S' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = $silentArgs
  softwareName  = 'ReadyNAS Remote' 
  }
Install-ChocolateyPackage @packageArgs
