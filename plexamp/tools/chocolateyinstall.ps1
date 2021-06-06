$ErrorActionPreference = 'Stop'
$packageName    = 'plexamp'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = "https://plexamp.plex.tv/plexamp.plex.tv/desktop/Plexamp%20Setup%20$env:ChocolateyPackageVersion.exe"
$checksum64     = '08454DC2F6532249CF2CA59234BA97D8BDCCF3475AF177BE6FF5EFEFDCCB9659'

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
