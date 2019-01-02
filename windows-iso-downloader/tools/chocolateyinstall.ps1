$packageName   = 'windows-iso-downloader' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.heidoc.net/php/Windows%20ISO%20Downloader.exe'
$checksum      = '5F13A7CC0BAFE6268CF55551A7D05239EACEF33923C28A5C815CF5714EEBCE45'
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
