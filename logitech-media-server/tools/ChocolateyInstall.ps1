$packageName= 'logitech-media-server' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.slimdevices.com/LogitechMediaServer_v7.7.6/LogitechMediaServer-7.7.6.exe' 
$checksum   = 'E0F23BDFF0FF256F61C77F494F813244472E0EF0DDA2278B26B579EF93E6DA37'
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
