$ErrorActionPreference = 'Stop'
$url           = 'https://www.seagate.com/files/www-content/support-content/downloads/seatools/_shared/downloads/SeaToolsWindowsInstaller.exe'
               # ^ persistent
$checksum      = '4F5EF85BD8FC9A5B53B72A448122E0F8E266CAE1FA0BA8AF50644231B943F15F'

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
