$packageName = 'pacman' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\pacman.zip"
$checksum    = '845F8303900F963A420A85E0A84AA40D6BD90867079975887E5246FDD8EB5DE0'
$Shortcut    = 'Pacman.lnk'
$ProgramEXE  = 'PACMAN.exe'

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
  }

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$Shortcut" -targetPath "$toolsDir\$ProgramEXE" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$Shortcut" -targetPath "$toolsDir\$ProgramEXE"    

Remove-Item $url | out-null