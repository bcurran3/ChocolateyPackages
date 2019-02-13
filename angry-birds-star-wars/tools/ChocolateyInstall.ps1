$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.rovio.angrybirdsstarwars.ads.iap/Angry_Birds_Star_Wars-gameslol.exe'
$checksum       = '97B86CFF43A0960407A7FF94A8D5B58ED66AF8896FDA1E861BC999270437595D'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\ABSWinstall.ahk"

$packageArgs = @{
  packageName   = 'angry-birds-star-wars' 
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = ''
  softwareName  = 'MobiGame'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Start-Process $ahkExe $ahkFile
Install-ChocolateyPackage @packageArgs
Start-sleep 2
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Angry Birds Star Wars.lnk" -ea SilentlyContinue
Start-CheckAndStop "mobinotifier"
Start-CheckAndStop "mobiplayer"
