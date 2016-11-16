$ErrorActionPreference = 'Stop'
$packageName   = 'gsuite-migration-exchange'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://dl.google.com/exchangemigration/GoogleAppsMigration.msi' 
$checksum      = 'E316A97A626C045E4579CDD7F6513C2890AA184054BC3D3AB171ED909EC00438'
$silentArgs    = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'Google Apps Migration For Microsoft*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
