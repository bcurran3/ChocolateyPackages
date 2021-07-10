$ErrorActionPreference = 'Stop'
$packageName    = 'plexamp'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = "https://plexamp.plex.tv/plexamp.plex.tv/desktop/Plexamp%20Setup%20$env:ChocolateyPackageVersion.exe"
$checksum64     = '9DE0CE63CCF954EA6D69595B7B4478E96473A2C2AA5D8CAECD1A0F2F0733F7CB'

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
