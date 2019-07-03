$ErrorActionPreference = 'Stop'
$packageName = 'osfmount' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'http://www.osforensics.com/downloads/osfmount.exe'
$checksum64  = 'CAB9D41CADF68A21BE72C80CE998B08AFBB696CF7C54467BDE4A6036D40CF74E'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE' 
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName   = 'OSFMount*' 
  }

Install-ChocolateyPackage @packageArgs
