$packageName = 'go-contact-sync-mod'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://sourceforge.net/projects/googlesyncmod/files/Releases/3.10.18/SetupGCSM-3.10.18.msi' 
$checksum    = '2599FF78088EAD5182F99C20E34BE210A1962D862258C32CFE4566E811AB2117'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url           = $url
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = 'Go Contact Sync Mod*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
