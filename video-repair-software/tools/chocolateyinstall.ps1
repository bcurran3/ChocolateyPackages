$ErrorActionPreference = 'Stop'
$packageName  = 'video-repair-software'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://grauonline.de/download/videorepair.zip'
$checksum     = '07C2FCFF53524A38E038E24B72E22B0287AE18FDAB4F5F81B05E7AD227425A00'
$shortcutName = 'Video Repair Software.lnk'
$exe          = 'videorepair\gs.exe'


$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\$packageName"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\$packageName"

