$packageName   = 'ext2ifs'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installerType = 'exe'
$url           = 'http://www.fs-driver.org/download/Ext2IFS_1_12.exe'
$checksum      = '21D96D83BF69BF7D498E2AD95153EC4DD15CFC700FECC73BF42545E3DCBEA393'
$silentArgs    = '/silent'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'Ext2 IFS 1.12 for Windows*' 
  checksum      = $checksum 
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs

