$ErrorActionPreference = 'Stop'
$packageName  = 'hppark' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://ftp.hp.com/pub/softlib/software13/COL40860/ds-99433-23/PARK-v1.8.7.zip'
$checksum     = 'E19193F95185A5668F724696B083653BF19AF24045A694200FF2957A2A6B02C1'
$shortcutName = 'HP PARK.lnk'
$subfolder    = "HP PARK-v$ENV:ChocolateyPackageVersion"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$subfolder"
