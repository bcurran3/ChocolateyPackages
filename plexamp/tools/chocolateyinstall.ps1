$packageName    = 'plexamp'
$installerType  = 'exe'
$url            = 'https://plexamp.plex.tv/plexamp.plex.tv/Plexamp%20Setup%201.0.5.exe'
$checksum       = '928BFCADBF35A562CDA83AF55E4234CD887689A6DD913393A44EBE37E49DCEC7'
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

