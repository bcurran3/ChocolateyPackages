$ErrorActionPreference = 'Stop'
$packageName= 'logitech-media-server' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.slimdevices.com/LogitechMediaServer_v7.9.2/LogitechMediaServer-7.9.2.exe' 
$checksum   = 'D7B23A257AE6B033D89D5FD931B60D4AE8282B677CCD00BFFA094BB261F665CC'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  validExitCodes= @(0) 
  softwareName  = 'Logitech Media Server*' 
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
