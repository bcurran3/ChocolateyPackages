$packageName    = 'google-play-music-manager' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url            = 'https://dl.google.com/androidjumper/win/musicmanagerinstaller.exe'
$url            = 'https://dl.google.com/tag/s/appguid%3D%7BEA25377A-280A-4539-8FED-21FACE57594F%7D%26iid%3D%7BC4384B00-048D-9ECC-BF34-86A3BB1EF491%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DMusic%2520Manager%26needsadmin%3Dfalse/androidjumper/win/musicmanagerinstaller.exe'
$checksum       = '2C6ED4BC877FE702224F72979C015465768A098B9871B18B1BA3900F76F6333B'
$validExitCodes = @(0)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "GPMMinstall.ahk"

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

if((get-process "MusicManager" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "MusicManager currently NOT running." -foreground green
  }else{ 
    Write-Host "Stopping MusicManager process..." -foreground yellow
    Stop-Process -processname "MusicManager"
  }


