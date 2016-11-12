$ErrorActionPreference = 'Stop'
$packageName= 'pdq-deploy'
$softwareName = 'PDQ Deploy*'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www2.adminarsenal.com/download-pdqdeploy' 
$checksum   = '2F20D0D186B2FFEC78BBA9B5EBE6215DC884C3A9441F5FF8D86216D99A4FBDE1'
$silentArgs = '/S'
$validExitCodes= @(0)
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\PDQDeploy.11.2.0.0.exe"

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
  
