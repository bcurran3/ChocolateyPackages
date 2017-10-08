$ErrorActionPreference = 'Stop'
$packageName  = 'snake-java'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.sourceforge.net/project/spypunk-snake/snake-1.7.0.zip'
$checksum     = '05B03846B5D602FBC9F75E913A1680002A13A84051E4944E4C009565E18128CB'
$extractedDir = 'snake-1.7.0'
$ExeFile      = 'snake.jar'
$ShortcutName = 'snake.lnk'

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














