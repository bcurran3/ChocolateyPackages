# https://www.plex.tv/media-server-downloads/#plex-app
$ErrorActionPreference = 'Stop'
$packageName   = 'plexmediaplayer'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits          = Get-ProcessorBits
$url           = 'https://downloads.plex.tv/plexmediaplayer/2.27.0.949-542ba3ed/PlexMediaPlayer-2.27.0.949-542ba3ed-windows-x64.exe'
$checksum      = '239EFD820E201BF51D3A6A2FE4F408030DEA5B1BF64018057E09CFDBA70B58EA'

if ($bits -eq 32){
    Write-Warning "This program only supports 64 bit OSes. Aborting..."
    throw
   }

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  silentArgs    = '/S'
  softwareName  = 'Plex Media Player' 
  checksum      = $checksum
  checksumType  = 'sha256'  
 }

Install-ChocolateyPackage @packageArgs
