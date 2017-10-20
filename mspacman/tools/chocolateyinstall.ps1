$packageName = 'mspacman' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\mspacman.zip "
$checksum    = 'CA90BDCB36091A32FF34FC273073D444330A6D9FD42BA90869D542D0CAC5479C'
$Shortcut    = 'Ms Pacman.lnk'
$ProgramEXE  = 'mspacman.exe'

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