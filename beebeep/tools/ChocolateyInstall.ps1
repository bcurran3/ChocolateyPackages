$packageName  = 'beebeep' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.sourceforge.net/project/beebeep/Windows/beebeep-5.2.0.zip'
$checksum     = 'EB7C94D09435493E0D2229FC2F6288FE8654236702AAE7E2E6083504A90F4A07'
$ShortcutName = 'beeBEEP'
$unzipDir     = 'beebeep-5.2.0'
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
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
