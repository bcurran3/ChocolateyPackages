$packageName= 'go-contact-sync-mod'
$installerType = 'msi'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://pilotfiber.dl.sourceforge.net/project/googlesyncmod/Releases/3.10.13/SetupGCSM-3.10.13.msi' 
$checksum   = 'E00F98E9D0F5D644DE4C0F981AE51A2BA95ADC91BB1DDEC0CCE75449AD26554F'
$silentArgs = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType 
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'Go Contact Sync Mod*' 
  checksum      = $checksum
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
