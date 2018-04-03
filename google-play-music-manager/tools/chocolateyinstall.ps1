$packageName    = 'google-play-music-manager' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/androidjumper/win/musicmanagerinstaller.exe'
$checksum       = 'A267CA8DD5CC654C23771C89C26AE3CC713F9C6F82110A977037D801E5C40B62'
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
    Write-Host "MusicManager currently NOT running." 
  }else{ 
    Write-Host "Stopping MusicManager process..."
    Stop-Process -processname "MusicManager"
  }


