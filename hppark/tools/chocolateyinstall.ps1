$packageName  = 'hppark' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://ftp.hp.com/pub/softlib/software13/COL40860/ds-99433-21/PARK-v1.8.4.zip'
$checksum     = '446389DF54FB24EC138E05303AAB5C4FD54D9DD8236DEE65F882C8A058438883'
$shortcutName = 'HP PARK.lnk'
$folder       = 'HP PARK-v1.8.4'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$folder"