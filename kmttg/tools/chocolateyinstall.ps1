$packageName = 'kmttg' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://svwh.dl.sourceforge.net/project/kmttg/kmttg_v2.2s.zip'
$checksum    = '1A8A3A82FF5D9D5C9B52EEBD7C19B92DF3E48B6E0B63CE2730AF93242EBE2F9C'

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

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T
