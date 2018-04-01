$ErrorActionPreference = 'Stop'
$packageName= 'osfmount' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.osforensics.com/downloads/osfmount.exe'
$checksum   = 'A7085A13E5FBDCD7BB1D34AEFE291446F01DA1413235908B3242079557C72F7B'
$url64      = 'http://www.osforensics.com/downloads/osfmount_x64.exe'
$checksum64 = 'B466B7E6AFD66192F6F0E2BFB738874E428E7D09980E65AFAB0B851CD684B335'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = $silentArgs
  softwareName  = 'OSFMount*' 
  }
Install-ChocolateyPackage @packageArgs
