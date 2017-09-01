$packageName   = 'seatools'
$installerType = 'exe'
$url           = 'http://www.seagate.com/files/www-content/support-content/downloads/seatools/_shared/downloads/SeaToolsforWindowsSetup.exe'
$checksum      = '87C458669F52960A8AC4BCD7578C6830003D874D7C0B425CEDA0B0E1020D8F62'
$silentArgs    = '/S'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'SeaTools*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

