$packageName  = 'go-contact-sync-mod'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://downloads.sourceforge.net/project/googlesyncmod/Releases/3.10.15/SetupGCSM-3.10.15.msi' 
$checksum   = 'D9B335EDE7BA020E11233A9F9E3F54F47C67102910A4CC744B55FDF6D6568EA3'


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
