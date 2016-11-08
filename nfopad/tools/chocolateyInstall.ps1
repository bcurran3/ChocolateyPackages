$ErrorActionPreference = 'Stop'
$packageName= 'nfopad'
$installerType = 'exe'
$silentArgs = '/S'
$url        = 'http://truehumandesign.se/download/nfopad171.exe'
$validExitCodes= @(0)
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$packageArgs = @{
  packageName   = $packageName
#  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'NFOPad*' 
  checksum      = '977D05B371DBD9AE3455A445B2FA32E56117BC3334F731E9243C1A13FF6E9847'
  checksumType  = 'sha256'
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs



						  
						  
						  
						  
