$ErrorActionPreference = 'Stop'
$packageName= 'disk-wipe' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://www.diskwipe.org/download/DiskWipe.exe'
$checksum   = '8FD1B5431DBA0707EA186B66E882C9A84D6B6033A07A35CB7FC319CF3A744D57'
$installerPackage = Join-Path $ToolsDir "DiskWipe.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\DiskWipe.lnk" -targetPath "$toolsDir\DiskWipe.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\DiskWipe.lnk" -targetPath "$toolsDir\DiskWipe.exe"
