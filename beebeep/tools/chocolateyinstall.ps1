$packageName  = 'beebeep' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.sourceforge.net/project/beebeep/Windows/beebeep-4.0.0.zip'
$checksum     = '75DAC37FF7C77213EDF2FCFDFAF928B1E5FE35C3ED052581B01455A93A32D60D'
$ShortcutName = 'beeBEEP'
$unzipDir     = 'beebeep-4.0.0'
$exe          = 'beeBEEP.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  }

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
