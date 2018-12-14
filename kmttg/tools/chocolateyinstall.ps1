$packageName = 'kmttg' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/kmttg/kmttg_v2.4l.zip'
$checksum    = '76B0C6BF7A2CE6163CD4379CD16503B53C6A9EA2D2DBA01C3811142A6256246B'

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

