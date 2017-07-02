$packageName  = 'dell-platform-tags-utility' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.dell.com/FOLDER03706387M/1/Setup.exe'
$checksum     = '6FFAA93612CC03A881CE9358C69A96EE10597D32D2082B54935B5546F5DEE765'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
