$packageName   = 'plexmediaplayer'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://downloads.plex.tv/plexmediaplayer/2.1.1.703-79cdfa5c/PlexMediaPlayer-2.1.1.703-79cdfa5c-windows-x64.exe'
$checksum      = 'DAEA972A238BCCE5E05FC8ADB703E004F4ADD0837027CBCC1ACC3D989A548217'
$silentArgs    = '/S'
$bits          = Get-ProcessorBits

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

if ($bits -eq 32)
  {
   Write-Host "This program only supports 64 bit OSes." -foreground "red" –backgroundcolor "blue"
   throw
  } else {  
    Install-ChocolateyPackage @packageArgs
   }  

