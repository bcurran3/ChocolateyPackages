$packageName   = 'windows-iso-downloader' 
$global:packageMaintainer = 'BCURRAN3'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.heidoc.net/php/Windows%20ISO%20Downloader.exe'
$checksum      = '18675BC92C169667D5D5F28E39B577E7F6EE0150B30150FB92237064CFD5B1A5'
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

Show-Patreon "https://www.patreon.com/bcurran3"
Get-ChocolateyWebFile @packageArgs
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir\$packageName"
