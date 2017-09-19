$ErrorActionPreference = 'Stop'
$packageName   = 'windows-iso-downloader' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.heidoc.net/php/Windows%20ISO%20Downloader.exe'
$checksum      = 'F4FD01DBE11563DCD997572B71D436148AE4DB9650653A28AFFF7AF4BD49EEBB'
$ExeFile       = 'Windows ISO Downloader.exe'
$ShortcutName  = 'Microsoft Windows and Office ISO Download Tool.lnk'
$FileFullPath  = Join-Path $toolsDir $ExeFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  FileFullPath  = $FileFullPath
  softwareName  = ''
  }

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
