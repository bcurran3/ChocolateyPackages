$packageName  = 'yakyak' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/yakyak/yakyak/releases/download/v1.4.2/yakyak-1.4.2-win32-x64.zip'
$checksum     = 'F82BAD833A441FC984D4BF173D43C673028AF57931873D12ABAFD863FBE1EA73'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'    
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\YakYak.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\win32-x64\yakyak.exe"
