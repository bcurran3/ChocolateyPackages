$packageName    = 'cms-magic-series'
$installerType  = 'MSI'
$url            = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.2.4.2028-win32.msi' 
$checksum       = 'BE9FC352EACB0A9FCF8D90DE0304500AE4E631FA62C502F867DCF9379955262D'
$url64          = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.2.4.2028-win64.msi' 
$checksum64     = 'E733FC55F94B8C7ECF65590653BD4D5C10B2EB6481FAF302A24C104AE94509E6'
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
