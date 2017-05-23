$ErrorActionPreference = 'Stop'
$packageName   = 'gsuite-migration-exchange'
$installerType = 'msi'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://dl.google.com/exchangemigration/GoogleAppsMigration.msi' 
$checksum      = '18E9548BD1AD8E0E4DE73D5A983AB01CD39EA6B9513E1DA68FCE6DEFB27EF66B'
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
  
