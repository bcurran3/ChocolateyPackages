$ErrorActionPreference = 'Stop'
$url           = 'https://www.seagate.com/files/www-content/support-content/downloads/seatools/_shared/downloads/SeaToolsWindowsInstaller.exe'
$checksum      = '2D98BAD583599491E782CF60319DDBB6C437874F5E03E07A7ECBE3022CF5D105'

$packageArgs = @{
  packageName   = 'seatools'
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  silentArgs    = '--mode unattended'
  softwareName  = 'SeaTools*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
