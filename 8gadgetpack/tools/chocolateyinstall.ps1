$ErrorActionPreference = 'Stop'
$packageName    = '8gadgetpack'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://8gadgetpack.net/dl-280/8GadgetPackSetup.msi'
$checksum       = 'B262D8A5F727EBEC72BA68C7D3E86B2310B42F674E222B1D5A5E57CFA9062618'

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
  
