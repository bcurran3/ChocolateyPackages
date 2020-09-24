$ErrorActionPreference = 'Stop'
$packageName    = 'nfopad'
$url            = 'http://www.truehumandesign.se/download/nfopad175.exe'
$checksum       = '7354FD5A6E5C63FABDC03FB0CE472CBCC9707D08B10DF2B610927959330900D3'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE' 
  url            = $url
  softwareName   = 'NFOPad*' 
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
