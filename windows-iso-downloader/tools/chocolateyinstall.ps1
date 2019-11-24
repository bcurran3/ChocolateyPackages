$ErrorActionPreference = 'Stop'
$packageName   = 'windows-iso-downloader' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.heidoc.net/php/Windows%20ISO%20Downloader.exe'
$checksum      = '5B7B7E392A3A24034F2C0ACEA00B2DD7BA816C7EDD26B1B66C6E04EF8A813CE1'
$ExeFile       = 'Windows ISO Downloader.exe'
$ShortcutName  = 'Microsoft Windows and Office ISO Download Tool.lnk'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  FileFullPath  = "$toolsDir\$ExeFile"
  softwareName  = ''
  }

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
