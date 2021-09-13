$ErrorActionPreference = 'Stop'
$packageName    = 'plexamp'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = "https://plexamp.plex.tv/plexamp.plex.tv/desktop/Plexamp%20Setup%20$env:ChocolateyPackageVersion.exe"
$checksum64     = '375104F23C492ADA8E9C5DF9BC6C448D6F571A2B8DDAD4C5E9938256AB3D4B1A'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir  
  fileType       = 'EXE'
  url64          = $url64
  validExitCodes = @(0,1)
  silentArgs     = '/S'
  softwareName   = 'Plexamp*'
  checksum64     = $checksum64
  checksumType64 = 'sha256' 
}

Install-ChocolateyPackage @packageArgs
