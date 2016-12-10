$packageName= 'mfsr' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#URL from http://www.tivocommunity.com/community/index.php?threads/mfs-reformatter-mfsr.528428/
$url        = 'https://dl.dropboxusercontent.com/u/59367797/MFSR1004.zip'
$checksum   = 'F18A28F5036409327A593BF8DFEC26A204AA95EC5E1D44BB23E95E88857F522D'
$installerPackage = Join-Path $toolsDir "mfsr.exe"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
}
 
Install-ChocolateyZipPackage @packageArgs

