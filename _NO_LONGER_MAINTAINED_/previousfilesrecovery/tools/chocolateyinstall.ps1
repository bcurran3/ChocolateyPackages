$ErrorActionPreference = 'Stop'
$packageName  = 'previousfilesrecovery' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/previousfilesrecovery.zip'
$checksum     = '62992BADA592BBD7E3B5152B28D6F63D4CB0290EFCC7F324143DB4356747429B'
$url64        = 'http://www.nirsoft.net/utils/previousfilesrecovery-x64.zip'
$checksum64   = '5EAFF225D06ABAFC8528BDE9ED6B6576B9BCD4229471DF9BCC2DAF986CAA276F'
$shortcutName = 'PreviousFilesRecovery.lnk'
$exe          = 'PreviousFilesRecovery.exe'

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
