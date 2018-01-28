$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www2.adminarsenal.com/download-pdqinventory' 
$checksum       = '80B9F2BBAD5026B1ACECD8A53575D9261627EAFC7C1D6A482ADA65DE4716211B'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\PDQInventory.15.1.0.0.exe"

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
  fileType      = 'EXE'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = $softwareName
}
 
Install-ChocolateyInstallPackage @packageArgs
  
