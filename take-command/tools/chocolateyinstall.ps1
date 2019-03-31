$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v24/tcmd.exe'
$checksum    = 'B4FFE2C6FEA2D4D373EBD7460357E7A742913FC2EA031ADD5FFD0794F9C44F22'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
  softwareName   = 'Take Command*'
  silentArgs     = '/Q'
  validExitCodes = @(0) 
}

Install-ChocolateyPackage @packageArgs 
