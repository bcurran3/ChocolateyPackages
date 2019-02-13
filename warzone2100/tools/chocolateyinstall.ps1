$ErrorActionPreference = 'Stop'
$packageName    = 'warzone2100'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/warzone2100/archives/unsupported/Warzone2100-3.2/3.2.3/warzone2100-3.2.3.exe' 
$checksum       = 'D32F78545C63767D6E51D2A3BFA2C8BB46BF3238284B0471F8F939950EBF98D1'

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
