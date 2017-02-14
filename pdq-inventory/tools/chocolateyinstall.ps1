$ErrorActionPreference = 'Stop'
$packageName= 'pdq-inventory'
$softwareName = 'PDQ Inventory*'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www2.adminarsenal.com/download-pdqinventory' 
#https://aafiles.blob.core.windows.net/files/PDQInventory_12_2_0_0_f86a994b-8c1e-479c-8888-5ab9a4e9a49e.zip
$checksum   = '6293266F2A0F994E0731B437CE464B7AF9D9BE606D56365C949C0F038FF410B7'
$silentArgs = '/S'
$validExitCodes= @(0)
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\PDQInventory.12.2.0.0.exe"

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
  
