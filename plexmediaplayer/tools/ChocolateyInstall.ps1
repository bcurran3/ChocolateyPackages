$packageName   = 'plexmediaplayer'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits          = Get-ProcessorBits
# https://www.plex.tv/media-server-downloads/#plex-app
$url           = 'https://downloads.plex.tv/plexmediaplayer/2.18.0.893-48795f25/PlexMediaPlayer-2.18.0.893-48795f25-windows-x64.exe'
$checksum      = '21F14A2AF2D88A59A71069BAC5FEC1D4D7D27689D4202269C7EB4DB258DA0B8C'

if ($bits -eq 32){
    Write-Warning "This program only supports 64 bit OSes."
    throw
   }


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/S'
  softwareName  = 'Plex Media Player' 
  checksum      = $checksum
  checksumType  = 'sha256'  
 }

Install-ChocolateyPackage @packageArgs
  

