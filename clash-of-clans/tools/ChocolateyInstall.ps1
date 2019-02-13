$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.supercell.clashofclans/Clash_of_Clans-gameslol.exe'
$checksum       = '09A64B5E1C498EE5B64C837E33A7CF6F68C0478DF14AD8A8DAFD9D249A44A646'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\COCinstall.ahk"

$packageArgs = @{
  packageName   = 'clash-of-clans' 
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
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Clash of Clans.lnk" -ea SilentlyContinue
Start-CheckAndStop "mobinotifier"
Start-CheckAndStop "mobiplayer"
