$packageName= 'go-contact-sync-mod'
$installerType = 'msi'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://iweb.dl.sourceforge.net/project/googlesyncmod/Releases/3.10.9/SetupGCSM-3.10.9.msi' 
$silentArgs = '/quiet /qn /norestart'
$validExitCodes= @(0, 3010, 1641)


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = $installerType 
  url           = $url
  silentArgs    = $silentArgs
  softwareName  = 'Go Contact Sync Mod*' 
  checksum      = '2F2544A37548371E4B397224C9CFA8429E5D3DA909CFEB6AA24BD376CFCE9278'
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyPackage @packageArgs
