$ErrorActionPreference = 'Stop'
$packageName    = 'pdq-deploy'
$softwareName   = 'PDQ Deploy*'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www2.adminarsenal.com/download-pdqdeploy' 
#https://aafiles.blob.core.windows.net/files/PDQDeploy_12_1_0_0_ca7e0a59-6b75-427e-9a38-2ca73ff56f8f.zip
$checksum       = 'C483AA064770A2EC72F4E74C861CB7727DCCCF0C27B249BA8C80D5FA23537846'
$silentArgs     = '/S'
$validExitCodes = @(0)
$fileLocation   = "$env:ChocolateyInstall\lib\$packageName\tools\PDQDeploy.12.1.0.0.exe"

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
  
