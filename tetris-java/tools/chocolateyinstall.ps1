$ErrorActionPreference = 'Stop'
$packageName      = 'tetris-java'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://github.com/spypunk/tetris/releases/download/1.13.0/tetris-1.13.0.zip'
$checksum         = 'ED3E1CCB1864184485F234043FF515F45ACD243D0EFD757465A1ACEB73F2F1B0'
$extractedDir     = 'tetris-1.13.0'
$ExeFile          = 'tetris.jar'
$ShortcutName     = 'tetris Java.lnk'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum 
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$extractedDir\$ExeFile" -iconLocation "$toolsDir\tetris.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$extractedDir\$ExeFile" -WorkingDirectory "$toolsDir" -iconLocation "$toolsDir\tetris.ico"














