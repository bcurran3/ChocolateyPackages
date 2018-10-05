$packageName   = 'windows-iso-downloader' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.heidoc.net/php/Windows%20ISO%20Downloader.exe'
$checksum      = '5964604FB367267F7CCB8A26EA979ADD76E434C6FA6BC79C63E24DA107F51474'
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

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
