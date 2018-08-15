$packageName  = 'beebeep' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.sourceforge.net/project/beebeep/Windows/beebeep-5.4.2.zip'
$checksum     = 'CFB0743A706453134825E76BC1CB0ADB89886C96AE3B5BCDF601C23A0119B868'
$ShortcutName = 'beeBEEP'
$unzipDir     = 'beebeep-5.4.2'
$exe          = 'beeBEEP.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  }

Show-Patreon "https://www.patreon.com/bcurran3"  
Install-ChocolateyZipPackage @packageArgs
Show-ToastMessage "beeBEEP installed." "Version $env:packageVersion."
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
