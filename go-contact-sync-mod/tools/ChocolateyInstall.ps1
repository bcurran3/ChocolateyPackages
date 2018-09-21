$packageName = 'go-contact-sync-mod'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/googlesyncmod/Releases/3.10.17/SetupGCSM-3.10.17.msi' 
$checksum    = 'E6C5E52D82C182A589F823CF9A3F0B326CBC8FC0E1AAAD2E2F83F965C8B0F9F5'


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
