$ErrorActionPreference = 'Stop'
$packageName= 'nfopad'
$installerType = 'exe'
$silentArgs = '/S'
$url        = 'http://truehumandesign.se/download/nfopad172.exe'
$checksum   = 'A0ABA03BADFAE16A0D5DA0C5055591356F04768BBDAA31A4A817810E276D1AB4'
$validExitCodes= @(0)
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


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



						  
						  
						  
						  
