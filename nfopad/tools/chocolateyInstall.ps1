$ErrorActionPreference = 'Stop'
$packageName    = 'nfopad'
$url            = 'http://www.truehumandesign.se/download/nfopad173.exe'
$checksum       = '6971B749A07EAEE9748995DDD4E70426F26F331731D4D0D0F98D13A7612C2ED3'
$installerType  = 'exe'
$silentArgs     = '/S'
$validExitCodes = @(0)
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'NFOPad*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs



						  
						  
						  
						  
