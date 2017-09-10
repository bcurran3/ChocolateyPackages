$ErrorActionPreference = 'Stop'
$packageName   = 'nfopad.portable'
$installerType = 'ZIP'
$url           = 'http://www.truehumandesign.se/download/nfopad173portable.rar'
$checksum      = 'B9449D03A2C4B3BD95A5FAF35202BF87C88314ADB7B3C8B06E0D39EC9258AD0B'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum 
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs



						  
						  
						  
						  
