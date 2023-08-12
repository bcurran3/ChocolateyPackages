$ErrorActionPreference = 'Stop';
$packageName  = 'dcplusplus.portable'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://sourceforge.net/projects/dcplusplus/files/DC%2B%2B%200.880/DCPlusPlus-0.880.zip'
$checksum     = '0e9290ea757f241fc156a17b644ff46adbe9284190ef36d50a25f6e6bc22c653'
$url64        = 'https://sourceforge.net/projects/dcplusplus/files/DC%2B%2B%200.880/DCPlusPlus-0.880-x64.zip'
$checksum64   = 'abb664eb84f8c1b4555dd2ec7f0556f8ad3d6f4385dfad85d3473909b47634c6'
$shortcutName = 'DC++.lnk'
$portableEXE  = "$toolsDir\DCPlusPlus.exe"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  url64          = $url64
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath $portableEXE -WorkingDirectory $toolsDir
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $portableEXE -WorkingDirectory $toolsDir

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
















