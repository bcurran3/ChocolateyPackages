$packageName = 'kmttg' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/kmttg/kmttg_v2.4h.zip'
$checksum    = 'C5F5C3B05E53CF13BC61AFF10D8182E02B0814D56C21F0C585A0B107F05417EE'

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
