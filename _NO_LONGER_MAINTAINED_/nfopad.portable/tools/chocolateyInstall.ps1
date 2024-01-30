$ErrorActionPreference = 'Stop'
$packageName   = 'nfopad.portable'
$installerType = 'ZIP'
$url           = 'http://www.truehumandesign.se/download/nfopad175portable.zip'
$checksum      = '3201630B0D172ECCFB8F0507C2274013DE239558D4B17565549131BEE712FDF2'
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



						  
						  
						  
						  
