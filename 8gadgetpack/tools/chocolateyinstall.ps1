$ErrorActionPreference = 'Stop'
$packageName    = '8gadgetpack'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://8gadgetpack.net/dl290/8GadgetPackSetup.msi'
$checksum       = '86E27E4DC41C23D194748427777E4B1776EFC2F64822ACEFF0C007809D79476B'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = '8GadgetPack'
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
