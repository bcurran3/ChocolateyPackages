$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = "https://plexamp.plex.tv/plexamp.plex.tv/desktop/Plexamp%20Setup%20$env:ChocolateyPackageVersion.exe"
$checksum64     = '21ADBE52EBAA3E0E84E4EB12BE536C3948E2A2A90ECE4F9DF3E610C6E21DC8B5'

$packageArgs = @{
  packageName    = 'plexamp'
  softwareName   = 'Plexamp*'
  fileType       = 'EXE'
  silentArgs     = '/S'
  file           = "$toolsDir\Plexamp Setup $env:ChocolateyPackageVersion.exe"
  validExitCodes = @(0,1)
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force -EA SilentlyContinue | Out-Null
