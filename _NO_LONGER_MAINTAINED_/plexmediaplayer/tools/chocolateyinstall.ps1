# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'
$packageName = 'plexmediaplayer'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloads.plex.tv/plexmediaplayer/2.58.0.1076-38e019da/PlexMediaPlayer-2.58.0.1076-38e019da-windows-x64.exe'
$checksum64  = '208FD446410174AAE17ACB12C89940C92589EA75ED18DB967E027AB2B3E4648B'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url64          = $url64
  silentArgs     = '/S'
  softwareName   = 'Plex Media Player' 
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
 }

Install-ChocolateyPackage @packageArgs
