$packageName  = 'dell-platform-tags-utility' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.dell.com/FOLDER04966038M/7/PlattagsSWB40270_ZPE.exe'
$checksum     = '7DD10973334119CE1DF7A6CE3347CFA0F5A7E1E5C4F387727DC824DDFF32451A'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
