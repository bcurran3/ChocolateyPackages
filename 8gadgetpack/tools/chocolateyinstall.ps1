$packageName    = '8gadgetpack'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://8gadgetpack.net/dl230/8GadgetPackSetup.msi' 
$checksum       = '814655C82CAA5F3B2993022C07C824E260194F003371E3866B2C60C130F5784E'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = '8GadgetPack'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
