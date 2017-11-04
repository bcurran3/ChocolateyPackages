$packageName = 'dcplusplus' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/dcplusplus/DC%2B%2B%200.867/DCPlusPlus-0.867.exe'
$checksum    = 'B807B6DE72072CE47CD360850ECC1B61FB36EC72F087794E484CB556123AD4E5'
$ahkExe      = 'AutoHotKey'
$ahkFile     = Join-Path $toolsDir "DCPPinstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs    = '/S' 
  softwareName  = 'DC++*' 
  checksum      = $checksum
  checksumType  = 'sha256'
  }
  
Install-ChocolateyPackage @packageArgs

