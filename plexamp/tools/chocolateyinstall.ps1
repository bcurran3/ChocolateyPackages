$packageName    = 'plexamp'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://plexamp.plex.tv/plexamp.plex.tv/Plexamp%20Setup%201.1.0.exe'
$checksum       = 'C38DE045826C02273C65563221676A9FCBC4638E167CAFEA9CC5B2400ACD2357'

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
