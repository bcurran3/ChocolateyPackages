$ErrorActionPreference = 'Stop'
$packageName= 'pdq-inventory'
$softwareName = 'PDQ Inventory*'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www2.adminarsenal.com/download-pdqinventory' 
$checksum   = 'EC72A6004CD70B058896CFAF4F315457F1639D114E76E17DD250222FFEE9FD8D'
$silentArgs = '/S'
$validExitCodes= @(0)
$fileLocation = "$env:ChocolateyInstall\lib\$packageName\tools\PDQInventory.11.2.0.0.exe"

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
  
