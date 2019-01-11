# https://www.plex.tv/media-server-downloads/#plex-app
$packageName   = 'plexmediaplayer'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits          = Get-ProcessorBits
$url           = 'https://downloads.plex.tv/plexmediaplayer/2.25.0.940-485e2ea4/PlexMediaPlayer-2.25.0.940-485e2ea4-windows-x64.exe'
$checksum      = '3021EC9411EF697334E4F530E69D59D9AD2A8F2C0B9A516A9A0C77BCA160D8B0'

if ($bits -eq 32){
    Write-Warning "This program only supports 64 bit OSes. Aborting..."
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
