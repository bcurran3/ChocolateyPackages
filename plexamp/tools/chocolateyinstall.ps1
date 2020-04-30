$packageName    = 'plexamp'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://plexamp.plex.tv/plexamp.plex.tv/desktop/Plexamp%20Setup%203.0.2.exe'
$checksum       = '2DC003DC7E97DBC96F5448E115E3617F1722D99D2E7E77D73F4831E06E7D1BB8'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0,1)
  silentArgs    = '/S'
  softwareName  = 'Plexamp*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
