$packageName   = 'plexmediaplayer'
$global:packageMaintainer = 'BCURRAN3'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'https://downloads.plex.tv/plexmediaplayer/2.14.1.880-301a4b6c/PlexMediaPlayer-2.14.1.880-301a4b6c-windows-x64.exe'
$checksum      = '9B58758D161843CDFDA6E5FA823D08CB55492B670E92D0E940A20EC59ED4AB77'
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
    Show-Patreon "https://www.patreon.com/bcurran3"
    Install-ChocolateyPackage @packageArgs
	Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
   }  

