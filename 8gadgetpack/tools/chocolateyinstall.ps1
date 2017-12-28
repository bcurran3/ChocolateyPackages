$packageName    = '8gadgetpack'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://8gadgetpack.net/dl_250/8GadgetPackSetup.msi' 
$checksum       = 'A27D70053A9823A33AB383AE8CBAD626BCE1824B456B629081D30165377AF6A0'
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
  
