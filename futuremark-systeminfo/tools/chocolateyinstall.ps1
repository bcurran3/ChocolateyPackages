$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$installerType  = 'MSI'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://d1ejs5fxm96rib.cloudfront.net/Futuremark_SystemInfo_v51_installer.msi' 
$checksum       = '0475AA8F9CF750E52E7F498987502FDD58A3FE9AE843A4F5A4AC63EF16558ACF'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Futuremark SystemInfo*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
