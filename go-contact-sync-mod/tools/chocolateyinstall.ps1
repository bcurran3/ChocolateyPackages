$packageName = 'go-contact-sync-mod'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://sourceforge.net/projects/googlesyncmod/files/Releases/3.10.19/SetupGCSM-3.10.19.msi' 
$checksum    = 'D500E2BFA4CC4D83BE90F7649CD83E60D119076FB98BE5279B74E08AE3D033CC'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = 'Go Contact Sync Mod*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
