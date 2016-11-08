$ErrorActionPreference = 'Stop'
$packageName= 'nfopad.portable'
$installerType = 'ZIP'
$url        = 'http://truehumandesign.se/download/nfopad171portable.rar'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '417DBAA78ECFAEB04F038A1AC8CDE413D5A496E4F7344E463A008C496D552D5D'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs



						  
						  
						  
						  
