$packageName   = 'plexmediaplayer'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://downloads.plex.tv/plexmediaplayer/2.1.0.74-8e24a8f4/PlexMediaPlayer-2.1.0.74-8e24a8f4-windows-x64.exe'
$checksum      = '214314E6ACB72858EC781BD20061EAB4C349A898D3FBD02839343BA3EB140F09'
$silentArgs    = '/S'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'Plex Media Player' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

