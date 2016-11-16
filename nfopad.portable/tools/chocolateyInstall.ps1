$ErrorActionPreference = 'Stop'
$packageName   = 'nfopad.portable'
$installerType = 'ZIP'
$url           = 'http://truehumandesign.se/download/nfopad172portable.rar'
$checksum      = '664D0475820BAC33AF2429883D76305CEF3D5DBEB4311140371DDE7008067E30'
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



						  
						  
						  
						  
