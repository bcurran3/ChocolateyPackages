$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v23/tcmd.exe'
$checksum    = 'B1F2D3361EE8C1F93EA1A5684E31BD0B1D24E319F95EFAE9EA46E0A75AB9CFF1'


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
