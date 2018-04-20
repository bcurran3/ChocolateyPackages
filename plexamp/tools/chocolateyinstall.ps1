$packageName    = 'plexamp'
$installerType  = 'exe'
$url            = 'https://plexamp.plex.tv/plexamp.plex.tv/Plexamp%20Setup%201.0.4.exe'
$checksum       = '7C3B4C9222AEA27791935C916B29CD34C5E349FCFBEC9DF0E5BF9A6C046C2282'
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

