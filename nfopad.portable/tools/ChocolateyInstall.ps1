$ErrorActionPreference = 'Stop'
$packageName   = 'nfopad.portable'
$installerType = 'ZIP'
$url           = 'http://www.truehumandesign.se/download/nfopad174portable.rar'
$checksum      = '4D5D68EF57436E03355A8FB7CCC83583ECB6390C8E047A6B6D1B93CDE4BD4703'
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



						  
						  
						  
						  
