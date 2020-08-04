$ErrorActionPreference = 'Stop'
$packageName    = 'plexamp'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64          = "https://plexamp.plex.tv/plexamp.plex.tv/desktop/Plexamp%20Setup%20$env:ChocolateyPackageVersion.exe"
$checksum64     = '6E29C386853D078EE48C30B00A63FB1B09E7E80E4C23D81981E6BFF3F324A02B'

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
