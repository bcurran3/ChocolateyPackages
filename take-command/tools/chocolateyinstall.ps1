$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v23/tcmd.exe'
$checksum    = '1CD3108006931DAC042AEBABB2A9A875CA95BEE505464E1BACA9849BB4A93ECD'


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
