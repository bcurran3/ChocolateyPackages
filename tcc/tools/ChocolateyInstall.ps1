$packageName = 'tcc'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://jpsoft.com/downloads/v23/tcc.exe'
$checksum    = '1D9A3871DEAE4B74E9AE3962CEC367A8AAFD529FD2521E3CFA13B640CB797A0F'

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
