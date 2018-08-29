$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.supercell.clashroyale/Clash_Royale-gameslol.exe'
$checksum       = '39AFDC41554AB34A64E1EA82956753DCBA103021734BD5DA6327AFAA8370CD04'
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
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Clash Royale.lnk" -ea SilentlyContinue
