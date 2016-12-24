$packageName= 'kmttg' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://iweb.dl.sourceforge.net/project/kmttg/kmttg_v2.2l.zip'
$checksum   = '9791DE947BD6BFEFB3A6AA0D64725B2BE98CF49719DAB3A90AC7400A947D87EE'

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
