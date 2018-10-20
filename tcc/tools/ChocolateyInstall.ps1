$packageName = 'tcc'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v23/tcc.exe'
$checksum    = '90DA00A26788A3469A7C6685DF16A4A51D1EBA041FA808C3FF0D168654AABAC4'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  silentArgs    = '/quiet'
  softwareName  = 'TCC 23' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
