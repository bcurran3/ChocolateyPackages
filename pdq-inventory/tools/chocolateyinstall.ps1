$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www2.adminarsenal.com/download-pdqinventory' 
$checksum       = 'BEBC69E5CF581E1C83092A4BF7D8A2757CAEE2469E1FD1B42FD35F1E26FA1F38'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\PDQInventory.14.3.0.0.exe"

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
  
