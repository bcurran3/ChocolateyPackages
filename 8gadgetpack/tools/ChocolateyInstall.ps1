$packageName    = '8gadgetpack'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://8gadgetpack.net/dl_260/8GadgetPackSetup.msi' 
$checksum       = '9F5B150B1529238420DD8D9CD0BF74D921699BEA32FBB421318AA9C8E71861ED'
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
  
