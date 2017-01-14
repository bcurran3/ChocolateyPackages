#http://mirror.os6.org/videolan/skin-editor/0.8.5/VLCSkinEditor_w32.zip
$packageName           = 'vlc-skin-editor' 
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url                   = "$toolsDir\VLCSkinEditor_w32.zip"
$checksum               = 'E918340A1CE5AE8924B2C1BBB018C0AD2E384FF6FCF40E12FC334F11EC34CA84'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum 
  checksumType  = 'sha256'  
  }
  
Install-ChocolateyZIPPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\VLC Skin Editor.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\VLCSkinEditor.exe"
Remove-Item $url