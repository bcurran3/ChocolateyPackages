$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.rovio.angrybirdsstarwars.ads.iap/Angry_Birds_Star_Wars-gameslol.exe'
$checksum       = '9911327F0BD4E32264150FF2E2F90E6D5FB15EA94B5EE07ECF414F3AFDA39AD9'
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

