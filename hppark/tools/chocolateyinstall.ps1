$packageName  = 'hppark' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://ftp.hp.com/pub/softlib/software13/COL40860/ds-99433-20/PARK-v1.8.3.zip'
$checksum     = '18FE778B8AF633FE3A877E3CE4CE24EA78A41D101505D197FD2389B85BCD3C2E'
$shortcutName = 'HP PARK.lnk'
$folder       = 'HP PARK-v1.8.3'

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