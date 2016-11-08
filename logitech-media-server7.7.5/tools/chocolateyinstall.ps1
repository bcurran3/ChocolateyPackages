$packageName= 'logitech-media-server' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://downloads.slimdevices.com/LogitechMediaServer_v7.7.5/LogitechMediaServer-7.7.5.exe' 
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = $silentArgs
  validExitCodes= @(0) 
  softwareName  = 'Logitech Media Server*' 
  checksum      = 'DB0094F646E8AA5FBBA9C7EFB89043492C2745BAFB7B21D384BFE5B1B661E1E5'
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
