$packageName    = 'cms-magic-series'
$installerType  = 'MSI'
$url            = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.2.5.2029-win32.msi' 
$checksum       = '317EDF3D8E632DF2C4786EB0003EC6A3C95100E33D9B521E0078BD858D7D07D5'
$url64          = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.2.5.2029-win64.msi' 
$checksum64     = '18D6DFFB8615352F732C96772326100499A33CC7FCC5EE9386C4A890F83248F3'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  url64bit      = $url64
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'CMS'
  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'
}
 
Install-ChocolateyPackage @packageArgs  
