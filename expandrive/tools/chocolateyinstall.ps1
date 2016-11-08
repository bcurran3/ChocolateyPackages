$ErrorActionPreference = 'Stop'
$packageName   = 'expandrive' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://expandrive.s3.amazonaws.com/expandrive_win/v5-4-1_published_2016-09-28_at_15_16_01/ExpanDriveInstaller.exe' 
$UnzippedMSI  = Join-Path $toolsDir 'ExpanDriveInstaller.msi'
$installerType = 'MSI'
$silentArgs    = '/passive /norestart ACCEPT=YES'
$validExitCodes= @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = '32443133E36105FCBC2E858E9DBB4872CC99EBD8CD9F670527BFD66DE79D0458'
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


