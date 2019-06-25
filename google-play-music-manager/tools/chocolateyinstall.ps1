$ErrorActionPreference = 'Stop'
$packageName    = 'google-play-music-manager' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/tag/s/appguid%3D%7BEA25377A-280A-4539-8FED-21FACE57594F%7D%26iid%3D%7B4902BC13-D0C8-BD14-94C9-7CE1F3EAB86D%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DMusic%2520Manager%26needsadmin%3Dfalse/androidjumper/win/musicmanagerinstaller.exe'
$checksum       = '415E50769EF1BA285DDC93E8B5492E3CEA411C298D17FCAB686E4EF8FC93928C'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\GPMMinstall.ahk"

Start-Process $ahkExe $ahkFile

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
  
Install-ChocolateyPackage @packageArgs

Start-CheckandStop "MusicManager"
Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
if ($ProcessWasRunning -eq "True") {$ProcessFullPath}
