$packageName    = 'google-play-music-manager' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url            = 'https://dl.google.com/androidjumper/win/musicmanagerinstaller.exe'
$url            = 'https://dl.google.com/tag/s/appguid%3D%7BEA25377A-280A-4539-8FED-21FACE57594F%7D%26iid%3D%7B750610B3-2733-C330-D467-F910F351B12A%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DMusic%2520Manager%26needsadmin%3Dfalse/androidjumper/win/musicmanagerinstaller.exe'
$checksum       = '02BD7DC4AA62E3D211E8D8FE578239ECD1070FBA332948CC1D36E39CFBCD67E5'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "GPMMinstall.ahk"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs    = '' 
  softwareName  = 'Music Manager*'
  checksum      = $checksum
  checksumType  = 'sha256'  
  validExitCodes = $validExitCodes
  }
  
Start-CheckandStop "MusicManager"
Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
if ($ProcessWasRunning -eq "True") {$ProcessFullPath}
