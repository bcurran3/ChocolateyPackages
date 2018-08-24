$packageName = 'go-contact-sync-mod'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/googlesyncmod/Releases/3.10.16/SetupGCSM-3.10.16.msi' 
$checksum    = '3538EE3D78AC0D3ECD0C229F9C6B687A4D0F18D9B38269761D0C7F6EAD7ECF21'


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
