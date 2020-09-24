$ErrorActionPreference = 'Stop'
$url        = 'https://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.5.2.2069-win32.msi'
$urlalt     = 'https://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/Old%20Version%20Software/CMS-IPT-2.5.2.2069-win32.msi'
$checksum   = '70E6E197CE261846ED9D53404C21C4A3C1EE722100B18BC0DBE575CD6E1BE152'
$url64      = 'https://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/CMS-IPT-2.5.2.2069-win64.msi'
$url64alt   = 'https://download.eyemaxdvr.com/XVST%20MAGIC%20SERIES/CMS/Old%20Version%20Software/CMS-IPT-2.5.2.2069-win64.msi' 
$checksum64 = 'CBC8C08F82864BAE438CBC347FD1651747FF7F3FC034423605782EB0EB490C67'

if (Test-URL "$url") {} else {if (Test-URL "$urlalt"){$url=$urlalt}}
if (Test-URL "$url64") {} else {if (Test-URL "$url64alt"){$url64=$url64alt}}

$packageArgs = @{
  packageName   = 'cms-magic-series'
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = 'CMS'
  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'
}
 
Install-ChocolateyPackage @packageArgs  
