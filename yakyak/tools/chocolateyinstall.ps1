$packageName  = 'yakyak' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/yakyak/yakyak/releases/download/v1.5.0/yakyak-1.5.0-win32-x64.zip'
$checksum     = '681C824D402ED70A6D253F1634E173CFB752390397AA047414525265D01668BF'
$ShortcutName = 'YakYak.lnk'
$unzipDir     = 'YakYak-win32-x64'
$exe          = 'YakYak.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'    
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"

