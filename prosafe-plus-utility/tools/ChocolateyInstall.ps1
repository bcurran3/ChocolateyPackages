$packageName    = 'prosafe-plus-utility' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$extractDir     = "$toolsDir\extracted"
$url            = 'http://www.downloads.netgear.com/files/GDC/GS105E/ProSAFE_Puls_Utility_V2.7.5.zip'
$checksum       = '854F6795BB0EBDA9A34B95A6FFC15AA876FC3479C2A0A11B372893D4ADEF42F2'
$url2           = "$extractDir\ProSAFE Plus Utility 2.7.5.exe"
$checksum2      = '4BF9EC21C7457571377B0C153941E061F32DB3D2C890A318F5302642F9DF0CDB'
$checksumType   = 'sha256'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\PPCinstall.ahk"


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extractDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url2
  checksum      = $checksum2
  checksumType  = $checksumType
  silentArgs    = ''
  softwareName  = 'ProSAFE Plus Utility' 
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Remove-Item $extractDir -recurse -ErrorAction SilentlyContinue
