$packageName    = 'plexamp'
$installerType  = 'exe'
$url            = 'https://plexamp.plex.tv/plexamp.plex.tv/Plexamp%20Setup%201.0.0.exe'
$checksum       = 'CD2E3DB4F6BF815AD96F2EB5C52C7566EEAFD9A4107F6E5C42D0EFE53AEBFE04'
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

