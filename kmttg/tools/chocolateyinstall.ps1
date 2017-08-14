$packageName = 'kmttg' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/kmttg/kmttg_v2.3a.zip'
$checksum    = 'C61CB009B8296A6122111CF87E4AF21C252763F5DD0DEB2ED0CAFDF251F6E58B'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\kmttg.lnk" -targetPath "$toolsDir\kmttg.jar" -WorkingDirectory $toolsDir -IconLocation "$toolsDir\kmttg.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\kmttg.lnk" -targetPath "$toolsDir\kmttg.jar" -WorkingDirectory $toolsDir -IconLocation "$toolsDir\kmttg.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
