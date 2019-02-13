$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.supercell.clashroyale/Clash_Royale-gameslol.exe'
$checksum       = '64F6EB1C9E17E8773819D5426A8633BE89EC7B2361C546BB8CC5D0C0CCE3A9E0'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\CRinstall.ahk"

$packageArgs = @{
  packageName   = 'clash-royale' 
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
Remove-Item "$ENV:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$ENV:USERPROFILE\Desktop\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$ENV:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Clash Royale.lnk" -ea SilentlyContinue
Start-CheckAndStop "mobinotifier"
Start-CheckAndStop "mobiplayer"
