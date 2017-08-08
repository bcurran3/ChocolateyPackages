$packageName  = 'hppark' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://ftp.hp.com/pub/softlib/software13/COL40860/ds-99433-18/park-v1.8.2.zip'
$checksum     = '6D67845DEA872317BF065F05C05289EE2E076664322B16A0D566465399297B76'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs