$packageName    = 'cms-magic-series'
$installerType  = 'MSI'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.2.3.2027-win32.msi' 
$checksum       = 'A095DE7B93F2826A21AAFE272FA5A5DEEA822E2033FD241D62FFEC7545DD689C'
$url64          = 'http://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.2.3.2027-win64.msi' 
$checksum64     = '55CBE78A6EAFBEA7A5B61C0D6A8E1A7A55D1821DBF411A8DAB49FB4744762F0A'
$silentArgs     = '/quiet /qn /norestart'
$validExitCodes = @(0, 3010, 1641)
$fileLocation   = "$env:ChocolateyInstall\lib\cms-magic-series\tools\CMS#unix-IPT#2.2.1.2025-win32.msi"

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
