$ErrorActionPreference = 'Stop';
$packageName = 'xmedia-recode'
$url         = 'https://www.xmedia-recode.de/download/XMediaRecode3445_setup.exe'
$checksum    = '4B9847DED6F8F0F6DC1889B0477AB19BE2DCF706C586E4C6C216B1FAB92021BB'


$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyPackage @packageArgs

