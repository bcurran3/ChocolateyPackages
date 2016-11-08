$ErrorActionPreference = 'Stop'
$packageName= 'allway-sync' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://allwaysync.com/content/download/allwaysync.exe'
$url64      = 'http://allwaysync.com/content/download/allwaysync-x64.exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = '6F9B786F540742980E25649B56B80EE9874EA718FD3C1A7FD75582D2AD377AC6'
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = 'DED0B40CC3DDEA3EE7FC597BADF6F29FD3EBC4CADE3A6A9D3C37C12B0EC5AD5A'
  checksumType64= 'sha256'
  silentArgs    = $silentArgs
  softwareName  = 'Allway Sync*' 
  }
Install-ChocolateyPackage @packageArgs
