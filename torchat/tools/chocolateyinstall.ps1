$ErrorActionPreference = 'Stop'
$packageName= 'torchat' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/downloads/prof7bit/TorChat/torchat-windows-0.9.9.553.zip'
$ShortcutName = 'TorChat'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'zip' 
  url           = $url
  checksum      = 'E7F2D8D4830260B7713EC42A3842F9AC03A7A7970AFE63C0C52F47992C4F3117'
  checksumType  = 'sha256'  
  }

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\bin\$packageName.exe" -WorkingDirectory "$toolsDir\bin"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\bin\$packageName.exe" -WorkingDirectory "$toolsDir\bin"
Rename-Item -Path "$toolsDir\bin\portable.txt" -NewName "portable.renamed.txt"
