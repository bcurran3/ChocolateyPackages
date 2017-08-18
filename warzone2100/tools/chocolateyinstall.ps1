$packageName    = 'warzone2100'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.sourceforge.net/project/warzone2100/releases/3.2.3/warzone2100-3.2.3.exe' 
$checksum       = 'D32F78545C63767D6E51D2A3BFA2C8BB46BF3238284B0471F8F939950EBF98D1'
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Warzone 2100*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
