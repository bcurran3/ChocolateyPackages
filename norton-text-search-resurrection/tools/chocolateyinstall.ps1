$ErrorActionPreference = 'Stop'
$packageName = 'norton-text-search-resurrection'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://gverkade.home.xs4all.nl/ts/ts.zip'
$checksum    = 'C7B819ECA45CD0C1D7DE88C5B7D62A4CFDA5D017C600B2396B45A0F927EE16A1'
 
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
}
 
Install-ChocolateyZipPackage @packageArgs
