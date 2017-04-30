$packageName  = 'shadowcopyview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/shadowcopyview.zip'
$checksum     = 'C89A84F28552F347DFF09B00D996C7F0DA3819419B546B431FCEDF8C88F4A6EF'
$url64        = 'http://www.nirsoft.net/utils/shadowcopyview-x64.zip'
$checksum64   = 'C7A67B199BE34756A3CA3E10701E7FF6B6F37FEBE7D481B78E5AA873DC1886C8'
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
