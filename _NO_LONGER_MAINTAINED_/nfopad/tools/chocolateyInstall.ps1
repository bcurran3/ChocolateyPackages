$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = 'nfopad'
$url            = 'https://truehumandesign.se/download/nfopad181.exe'
$checksum       = '9139ED7F97278EDF90EE8DC179E30A00D475A6CD34670B6E122E4D603C19DD6A'

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
