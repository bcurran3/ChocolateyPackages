$packageName  = 'yakyak' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/yakyak/yakyak/releases/download/v1.3.3/yakyak-win32-x64.zip'
$checksum     =

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
