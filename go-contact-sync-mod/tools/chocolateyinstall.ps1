$packageName= 'go-contact-sync-mod'
$installerType = 'msi'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://kent.dl.sourceforge.net/project/googlesyncmod/Releases/3.10.14/SetupGCSM-3.10.14.msi' 
$checksum   = '91C8B087A8AECDAA22101998326958D4AE4DC017A6DADD08155C5D5D0417F970'
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
