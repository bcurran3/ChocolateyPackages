$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.supercell.clashofclans/Clash_of_Clans-gameslol.exe'
$checksum       = '48E27D9E156368AC41E0359497BACF1EC572E60713116F1A73ED5DB6499F9DD2'
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

