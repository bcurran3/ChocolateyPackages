$packageName    = 'cms-magic-series'
$installerType  = 'MSI'
$url            = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.3.7.2048-win32.msi' 
$checksum       = '1B011F121F3117B230602AD67BB896057EF5D05B57C4D818BF283CC303AAF01A'
$url64          = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.3.7.2048-win64.msi' 
$checksum64     = 'E029C05213FC647434A96B7028351571F58A78F32BCF777458DDEA88A6DEAA1C'
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
