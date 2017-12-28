$packageName   = 'seatools'
$installerType = 'exe'
$url           = 'http://www.seagate.com/files/www-content/support-content/downloads/seatools/_shared/downloads/SeaToolsforWindowsSetup.exe'
$checksum      = 'C181762A2F4DAA32479FE2F85613E71E92D32A1026ADAB03DB85B337FCA47A45'
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

