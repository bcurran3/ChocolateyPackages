$ErrorActionPreference = 'Stop'
$packageName    = 'gsuite-migration-exchange'
$installerType  = 'msi'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/exchangemigration/GSuiteMigration.msi' 
$checksum       = '0C7216793B3B8B3D254BCD12CDBE3560649DA73A6D8FBC6CD774553D58C0C782'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'G Suite Migration For Microsoft*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
