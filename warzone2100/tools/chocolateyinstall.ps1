$ErrorActionPreference = 'Stop'
$packageName    = 'warzone2100'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/warzone2100/releases/3.4.1/warzone2100_win_x86_installer.exe' 
$checksum       = '379E7016AE282ACE7D672BE87C1AB447135E254BF00B0C71E979F64D8BEDFFAD'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/S'
  softwareName   = 'Warzone 2100*'
  checksum       = $checksum 
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
