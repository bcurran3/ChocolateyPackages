$ErrorActionPreference = 'Stop'
$packageName   = 'forticlientvpn'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://d3gpjj9d20n0p3.cloudfront.net/forticlient/downloads/FortiClientVPNSetup_6.4.8.1755.exe'
$checksum      = 'B85F5E9AECC86FF4FBBA25EA064604B48D3CA723FC4AFA7F5CEF3D289E21D84E'
$url64         = 'https://d3gpjj9d20n0p3.cloudfront.net/forticlient/downloads/FortiClientVPNSetup_6.4.8.1755_x64.exe'
$checksum64    = '4A0E4D3BB2F969FBBD61D67180604E035D89A44FC1D664B5CBA14368BB3FA671'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64         = $url64
  silentArgs    = '/QUIET /NORESTART'
  softwareName  = 'FortiClient VPN' 
  checksum      = $checksum
  checksum64    = $checksum64
  checksumType  = 'sha256'
  }

Install-ChocolateyPackage @packageArgs
