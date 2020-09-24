# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'
$packageName = 'plexmediaplayer'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://downloads.plex.tv/plexmediaplayer/2.36.0.988-0150ae52/PlexMediaPlayer-2.36.0.988-0150ae52-windows-x64.exe'
$checksum64  = '56541BE706CCC8365D4DED0AF651D3C89D7727624522D45909E47DCA505651E6'

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
