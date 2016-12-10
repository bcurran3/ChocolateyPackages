$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v5-4-2_published_2016-11-22_at_17_05_41/ExpanDriveInstaller.msi' 
$checksum      = 'EE321782F1E27AF1C852BF61D044384824E0AAA6EEE999D9DE4386E811101B6D'
$UnzippedMSI   = Join-Path $toolsDir 'ExpanDriveInstaller.msi'
$installerType = 'MSI'
$silentArgs    = '/passive /norestart ACCEPT=YES'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  file          = $UnzippedMSI
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'Arq*'   
}

Install-ChocolateyInstallPackage @packageArgs


