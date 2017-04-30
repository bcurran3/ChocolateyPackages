$packageName  = 'browseraddonsview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/browseraddonsview.zip'
$checksum     = '09DD21476C946899B974C8EA3BE121F557FA1E04E4719FF5AF73FF73736C1F33'
$url64        = 'http://www.nirsoft.net/utils/browseraddonsview-x64.zip'
$checksum64   = 'F17CF1B4CD8D8C3EBC3CA67DD78136F3201E2EE30E0CC8F18367E676878B545F'
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
