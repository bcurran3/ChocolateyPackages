$ErrorActionPreference = 'Stop'
$packageName  = 'prime95.portable' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://www.mersenne.org/ftp_root/gimps/p95v294b5.win32.zip'
$checksum     = 'A83FBD233AFD7AEC59CE0DF191E742BA22185FE85B0F13C3FF057DBD9FD7F3D9'
$url64        = 'https://www.mersenne.org/ftp_root/gimps/p95v294b5.win64.zip'
$checksum64   = '849735A66C5BAA80D4AAE6C5A65ABE91AD0F877CBDEC615026DA85E8EF4FA41E'
$ExeFile      = 'prime95.exe'
$ShortcutName = 'Prime95'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  url64         = $url64
  checksum      = $checksum
  checksumType  = 'sha256' 
  checksum64    = $checksum64
  checksumType64= 'sha256'  
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"