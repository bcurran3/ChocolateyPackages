$packageName  = 'yakyak' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/yakyak/yakyak/releases/download/v1.3.3/yakyak-win32-x64.zip'
$checksum     = 'ABBBC0F450F3E5DE190C3FDAB28B5E85FAE7C01B0898D4931DB508B2F9C9F985'

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
