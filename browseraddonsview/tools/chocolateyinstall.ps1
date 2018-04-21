$packageName  = 'browseraddonsview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/browseraddonsview.zip'
$checksum     = '06DEB3A5B082DF68F2AEC330AD59D10D7210440ED63519FDC0A9A1F319E6B547'
$url64        = 'http://www.nirsoft.net/utils/browseraddonsview-x64.zip'
$checksum64   = 'BF75AB6CF9E32EEF7B1C95EE166986B4B3D0359D2A7B7CEC844C1A6C09777E1D'
$shortcutName = 'BrowserAddonsView.lnk'
$exe          = 'BrowserAddonsView.exe'

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
