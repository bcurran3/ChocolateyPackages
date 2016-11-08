$packageName = 'seatools'
$installerType = 'exe'
$url = 'http://www.seagate.com/files/www-content/support-content/downloads/seatools/_shared/downloads/SeaToolsforWindowsSetup.exe'
$silentArgs = '/S'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'SeaTools*' 
  checksum      = 'A55E431FEFEAE8D44FE14DD385AF8922F556BDBC6401BF23962FFCE449CA851C'
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

