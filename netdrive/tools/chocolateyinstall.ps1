$packageName    = 'netdrive'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://files.bdrive.com/netdrive/builds/NetDrive3_Setup-3.1.205.exe' 
$checksum       = 'BD09B374F86229F6E8C5739263AB89A83900BBBF248BCEB46CD092616DE34234'
$silentArgs     = "/S"
$validExitCodes = @(0,1223)
$extractDir      = "$toolsDir\extracted"
$fileLocation    = "$extractDir\NetDrive3.msi"

New-Item $extractDir -type directory

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs 

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  file          = $fileLocation
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
  softwareName  = 'NetDrive*'
}
 
Install-ChocolateyInstallPackage @packageArgs

Remove-Item $extractDir -recurse | out-null
