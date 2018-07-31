$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$global:packageMaintainer = 'BCURRAN3'
$url            = 'https://d1x9snl812q4nd.cloudfront.net/installer/com.supercell.clashroyale/Clash_Royale-gameslol.exe'
$checksum       = 'BD170AA3C7DB5EE31E219D7C0A7BA5F515A773742E741F6A38BB2FF007ECEFC9'
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
Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs
Start-sleep 2
Show-ToastMessage "Clash Royale installed." "Version $env:packageVersion."
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\GamesLOL.lnk" -ea SilentlyContinue
Remove-Item "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Clash Royale.lnk" -ea SilentlyContinue
