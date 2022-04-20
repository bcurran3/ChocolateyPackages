$ErrorActionPreference = 'Stop'
$packageName    = '8gadgetpack'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://8gadgetpack.net/dl_340/8GadgetPackSetup.msi'
$checksum       = 'DFD69B596DFC48A4CC1260FDCA354B048DC0614801E2057B95A135CE3EF8BF12'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = '8GadgetPack'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
