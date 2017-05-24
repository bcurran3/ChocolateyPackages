$packageName    = 'google-play-music-manager' 
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/androidjumper/win/musicmanagerinstaller.exe'
$checksum       = '6A06D4094B76F3FFCAF7B2D06A16285E842F4F329AFC53BB1D383CD3CB155DE9'
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


