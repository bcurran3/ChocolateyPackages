$ErrorActionPreference = 'Stop'
$packageName    = '8gadgetpack'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://8gadgetpack.net/dl_330/8GadgetPackSetup.msi'
$checksum       = '04b45032bebfca4d6a3e7d4082e9871e8d7432950a05ee1a087f75959e428473'

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
  
