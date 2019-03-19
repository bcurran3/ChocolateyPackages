$ErrorActionPreference = 'Stop'
$packageName  = 'hppark' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://ftp.hp.com/pub/softlib/software13/COL40860/ds-99433-22/PARK-v1.8.6.zip'
$checksum     = '392B5A330951E38DA123DCCEB4B5CA3C6EE5DFE46E0C7DDABA085E25132D4130'
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
