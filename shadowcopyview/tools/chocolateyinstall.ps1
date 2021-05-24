$ErrorActionPreference = 'Stop'
$packageName  = 'shadowcopyview' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.nirsoft.net/utils/shadowcopyview.zip'
$checksum     = 'D588D7E13D5D0DF3E184DC6C66E3DFFC0EEBE045A0A3F49DB5FCCE04665E6D65'
$url64        = 'https://www.nirsoft.net/utils/shadowcopyview-x64.zip'
$checksum64   = '93446B998531EB7366740D113A37620A65953D6F1AE265D95B927502D1E69DED'
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
