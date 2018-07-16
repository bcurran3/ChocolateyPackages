$packageName  = 'beebeep' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.sourceforge.net/project/beebeep/Windows/beebeep-5.0.2.zip'
$checksum     = 'C8CC685AA5B5D3E55DA500B3E44CA9F8AEBCECF7B8FB4BB0D90474A1F8EEBEA4'
$ShortcutName = 'beeBEEP'
$unzipDir     = 'beebeep-5.0.2'
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
