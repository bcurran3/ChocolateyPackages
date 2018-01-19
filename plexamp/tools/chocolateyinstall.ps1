$packageName    = 'plexamp'
$installerType  = 'exe'
$url            = 'https://plexamp.plex.tv/plexamp.plex.tv/Plexamp%20Setup%201.0.1.exe'
$checksum       = '635F0E08037F042D95CB799C66581A079A2A30B9C99D5644CB790A0FB425105C'
$silentArgs     = '/S'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Plexamp*'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir  
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

