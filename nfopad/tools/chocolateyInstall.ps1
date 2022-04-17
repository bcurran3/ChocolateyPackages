$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'nfopad'
$url            = 'https://truehumandesign.se/download/nfopad18.exe'
$checksum       = '175A27CC49185683CB15967C44E791E8CD4E7BA9E0BEB2DEA512B45C24364E37'

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
