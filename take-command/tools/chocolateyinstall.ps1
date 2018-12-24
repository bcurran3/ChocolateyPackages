$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v24/tcmd.exe'
$checksum    = 'F0E51CF0E9A489D220BAB091E51E2CD69F11A4BFCB03F9B5384E697CC9F347FF'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
  softwareName   = 'Take Command*'
  silentArgs     = '/PASSIVE'
  validExitCodes = @(0) 
}

Install-ChocolateyPackage @packageArgs 
