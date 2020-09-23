$ErrorActionPreference = 'Stop'
$packageName  = 'beebeep'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = "$toolsDir\beebeep-" + "$ENV:ChocolateyPackageVersion" + ".zip"
$unzipDir     = "beebeep-" + "$ENV:ChocolateyPackageVersion"
$ShortcutName = 'beeBEEP'
$exe          = 'beeBEEP.exe'
 
$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP'
  url            = $url
  }
 
Install-ChocolateyZipPackage @packageArgs
 
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
 
Remove-Item $url | Out-Null
