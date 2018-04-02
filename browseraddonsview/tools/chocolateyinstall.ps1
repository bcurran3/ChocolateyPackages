$packageName  = 'browseraddonsview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://www.nirsoft.net/utils/browseraddonsview.zip'
$checksum     = 'E5FAFC16FBF2467473D861E510E1F3777E8553DACEF4EFE621FF6F2EBD7D3980'
$url64        = 'http://www.nirsoft.net/utils/browseraddonsview-x64.zip'
$checksum64   = '846A7B481403191CF2BEB10B48C9C6D59D5D2DC0829272F88B879694AA9F2246'
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
