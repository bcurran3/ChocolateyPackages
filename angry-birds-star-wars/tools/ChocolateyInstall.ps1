$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.rovio.angrybirdsstarwars.ads.iap/Angry_Birds_Star_Wars-gameslol.exe'
$checksum       = 'AF75F4B63533B99F225CA50C91CA5CEB8F6BD9920BCD28AB89391C7F2137BC52'
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
Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Start-sleep 2
Show-ToastMessage "Angry Birds Star Wars installed." "Version $env:packageVersion."
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Angry Birds Star Wars.lnk" -ea SilentlyContinue

