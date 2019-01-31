$ErrorActionPreference = 'Stop'
$packageName   = 'seatools'
$url           = 'http://www.seagate.com/files/www-content/support-content/downloads/seatools/_shared/downloads/SeaToolsforWindowsSetup.exe'
$checksum      = 'E5AB565391A6FB0E8F6B7794FCCC64CC409CDB4EBCD359664F5C7107590467A9'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  silentArgs    = '/S'
  softwareName  = 'SeaTools*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

