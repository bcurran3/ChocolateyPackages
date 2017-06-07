$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www2.adminarsenal.com/download-pdqinventory' 
#https://aafiles.blob.core.windows.net/files/PDQInventory_12_4_0_0_b7bd8513-1b50-43a3-8b18-b6db5fb59bc7.zip
$checksum       = 'CBF39265C33D90B206B40FA3CC0B604CFCA9866A2CA5159800AC0289816B74B1'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\PDQInventory.12.4.0.0.exe"

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
  
