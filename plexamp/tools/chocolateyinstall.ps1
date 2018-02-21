$packageName    = 'plexamp'
$installerType  = 'exe'
$url            = 'https://plexamp.plex.tv/plexamp.plex.tv/Plexamp%20Setup%201.0.2.exe'
$checksum       = '14D65CEEA18FE41EEE5B4A0BF5C2364B3B79C5378B73B27639E333121132AD8E'
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

