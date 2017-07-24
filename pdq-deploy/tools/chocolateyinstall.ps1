$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-deploy'
$softwareName   = 'PDQ Deploy*'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aafiles.blob.core.windows.net/files/PDQDeploy_13_3_0_0_edc3b0ab-58fc-4992-b8db-29ff282bad9c.zip'
$checksum       = '9BF64ABB1BA80265B4BB271D36C74953ABC4F4B2634F915A900B7DAE456B67D5'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$toolsDir\PDQDeploy.13.3.0.0.exe"

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
  
