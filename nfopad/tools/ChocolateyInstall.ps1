$ErrorActionPreference = 'Stop'
$packageName    = 'nfopad'
$url            = 'http://www.truehumandesign.se/download/nfopad174.exe'
$checksum       = 'CE7E7BC70C5D07269439438309D353FCACA005049566826AE429B3EC59EAD392'
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



						  
						  
						  
						  
