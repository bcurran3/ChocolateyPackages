$packageName= 'kmttg' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://iweb.dl.sourceforge.net/project/kmttg/kmttg_v2.2m.zip'
$checksum   = '3FC6E0947043FA35CC15EB1EF25FFFFFCC7651868B009BB9585EEFB4267F5FFC'

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
