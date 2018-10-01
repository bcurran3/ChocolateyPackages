$packageName= 'logitech-media-server' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.slimdevices.com/LogitechMediaServer_v7.9.1/LogitechMediaServer-7.9.1.exe' 
$checksum   = 'D2EB20833A01071A2583F440AFB235689FF4A70C3DBE0183853E1EC92A207ED3'
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
