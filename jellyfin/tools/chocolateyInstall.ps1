$ErrorActionPreference = 'Stop'
$packageName  = 'jellyfin'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ShortcutName = 'Jellyfin'
$exe          = 'jellyfin.exe'

Start-CheckandStop 'jellyfin'

$packageArgs = @{
  packageName    = $packageName
  FileFullPath   = "$toolsDir\jellyfin_"+$ENV:ChocolateyPackageVersion+"_windows-x86.zip"
  FileFullPath64 = "$toolsDir\jellyfin_"+$ENV:ChocolateyPackageVersion+"_windows-x64.zip"
  Destination    = "$ENV:ChocolateyToolsLocation\jellyfin"
}

Get-ChocolateyUnzip @packageArgs

if ($ProcessWasRunning -eq "True") {Start-Process $ProcessFullPath}

Install-BinFile -Name 'jellyfin' -Path "$ENV:ChocolateyToolsLocation\jellyfin\$exe"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$ShortcutName.lnk" -targetPath "$ENV:ChocolateyToolsLocation\jellyfin\$exe" -WorkingDirectory "$ENV:ChocolateyToolsLocation\jellyfin" -IconLocation "$ENV:ChocolateyToolsLocation\jellyfin\jellyfin-web\src\favicon.ico"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$ENV:ChocolateyToolsLocation\jellyfin\$exe" -WorkingDirectory "$ENV:ChocolateyToolsLocation\jellyfin" -IconLocation "$ENV:ChocolateyToolsLocation\jellyfin\jellyfin-web\src\favicon.ico"

Remove-Item "$toolsDir\*.zip" -EA SilentlyContinue | Out-Null
