$packageName = 'scramble' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\scramblex2.zip"
$checksum    = '8210BE8EFA4DF5BBCF57B9D22DCD9A8ED833312CFB570CDA5E54A6E529AEAA06'
$Shortcut    = 'Scramble.lnk'
$ProgramEXE  = 'scramblex2.exe'

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