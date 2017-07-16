$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-inventory'
$softwareName   = 'PDQ Inventory*'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#https://aafiles.blob.core.windows.net/files/PDQInventory_13_2_0_0_cb6596f4-019d-4548-b843-5b91718c73bb.zip
$url            = 'http://www2.adminarsenal.com/download-pdqinventory' 
$checksum       = '392ECD3C7D45C23CE6843A2192F5268448A87F383F69BF7CA92AF753A66C282E'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\PDQInventory.13.2.0.0.exe"

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
  
