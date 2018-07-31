$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.supercell.clashofclans/Clash_of_Clans-gameslol.exe'
$checksum       = '8C9741F60C656419B10AB678E0A72D4354AE124952AE8658E473F832EC2C86E1'
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
Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Start-sleep 2
Show-ToastMessage "Clash of Clans installed." "Version $env:packageVersion."
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Clash of Clans.lnk" -ea SilentlyContinue

