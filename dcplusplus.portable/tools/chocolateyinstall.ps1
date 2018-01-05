$ErrorActionPreference = 'Stop';
$packageName  = 'dcplusplus.portable'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://newcontinuum.dl.sourceforge.net/project/dcplusplus/DC%2B%2B%200.867/DCPlusPlus-0.867.zip'
$checksum     = '6E323740939944D544157278D47A67F5A6DCBA7B680CB83C63AB4B39928CB3E9'
$url64        = 'https://gigenet.dl.sourceforge.net/project/dcplusplus/DC%2B%2B%200.867/DCPlusPlus-0.867-x64.zip'
$checksum64   = 'C7854FE3ADD7B5375ED3BBA0BA26C197145CEF74637B048C55CFB85319A1DBBB'
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
















