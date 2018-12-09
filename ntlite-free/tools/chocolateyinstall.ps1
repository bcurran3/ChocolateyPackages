$ErrorActionPreference = 'Stop'
$packageName    = 'ntlite-free'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://downloads.ntlite.com/files/NTLite_setup_x86.exe' 
$checksum       = '2B493732AB96B1DB8323DF9B3054A2474F0648E785325DCF431C5B9039EF019D'
$url64          = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe' 
$checksum64     = '5A3D1BDCFE39EEA193ACCA3D52E50044AF9D4CAA269A2B51C0BD8CFA1DF425C8'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64
  validExitCodes= @(0)
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'NTLite*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs
