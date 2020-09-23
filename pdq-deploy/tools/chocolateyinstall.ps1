#https://link.pdq.com/DownloadLatest?Product=pdqdeploy
$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-deploy'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aafiles.blob.core.windows.net/files/PDQDeploy_17_2_0_0_fef0497c-d819-47b9-b115-c8e41f9fad94.zip'
$checksum       = '0739657360FFFCA54B706D92B6175931B1EAE3E319EDB2A68E16C2F686DD0017'
$fileLocation   = "$toolsDir\PDQDeploy.17.2.0.0.exe"

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
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $fileLocation
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'PDQ Deploy*'
}
 
Install-ChocolateyInstallPackage @packageArgs
