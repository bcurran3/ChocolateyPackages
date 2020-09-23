$ErrorActionPreference = 'Stop'
$packageName = 'osfmount' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'http://www.osforensics.com/downloads/osfmount.exe'
$checksum64  = 'CDCEFCA0912ED3C0DF1F5754B90265756D2A2A2A29943DD14ECEF2E623055B10'

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
