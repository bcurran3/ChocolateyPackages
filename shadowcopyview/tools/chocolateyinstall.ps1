$ErrorActionPreference = 'Stop'
$packageName  = 'shadowcopyview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.nirsoft.net/utils/shadowcopyview.zip'
$checksum     = 'F6BA78F19E0949393E33A82916664A6467B455B09A5E610769B52FEDD63C484E'
$url64        = 'https://www.nirsoft.net/utils/shadowcopyview-x64.zip'
$checksum64   = '627A0D2855BF7E4922F1A22610C44D880BE7D32BDCA2C3044097B07EE5E4BB81'
$shortcutName = 'ShadowCopyView.lnk'
$exe          = 'ShadowCopyView.exe'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe"    
