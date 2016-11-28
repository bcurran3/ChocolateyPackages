$packageName= 'kmttg' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://iweb.dl.sourceforge.net/project/kmttg/kmttg_v2.2j.zip'
$checksum   = 'A09A3D067F6B7E1D72093236946D276A22ACBA043EE5E0401B5812A1DC4D744D'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\kmttg.lnk" -targetPath "$env:ChocolateyInstall\lib\kmttg\tools\kmttg.jar"
