$ErrorActionPreference = 'Stop'
$packageName    = 'getdataback-simple'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.runtime.org/gdbprosetup.exe'
$checksum       = 'B9DE4AC29615E6116377F23E6AAAA7B4C2E1A772580712721F813C76E4E80904'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir  
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'GetDataBack*'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
