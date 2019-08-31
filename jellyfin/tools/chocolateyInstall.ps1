$ErrorActionPreference = 'Stop'
$packageName  = 'jellyfin'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ShortcutName = 'Jellyfin'
$exe          = 'jellyfin.exe'

$packageArgs = @{
  packageName    = $packageName
  FileFullPath   = "$toolsDir\jellyfin_"+$ENV:ChocolateyPackageVersion+"_windows-x86.zip"
  FileFullPath64 = "$toolsDir\jellyfin_"+$ENV:ChocolateyPackageVersion+"_windows-x64.zip"
  Destination    = "$toolsDir\jellyfin"
}

Get-ChocolateyUnzip @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\jellyfin\$exe" -WorkingDirectory "$toolsDir\jellyfin" -IconLocation "$toolsDir\jellyfin\jellyfin-web\src\favicon.ico"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\jellyfin\$exe" -WorkingDirectory "$toolsDir\jellyfin" -IconLocation "$toolsDir\jellyfin\jellyfin-web\src\favicon.ico"

Remove-Item "$toolsDir\*.zip" -EA SilentlyContinue | Out-Null
Write-Host "" | Out-File "$toolsDir\jellyfin\ffmpeg.exe.ignore"
Write-Host "" | Out-File "$toolsDir\jellyfin\ffprobe.exe.ignore"
Write-Host "" | Out-File "$toolsDir\jellyfin\nssm.exe.ignore"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null

if ($ProcessWasRunning -eq "True") {&$ProcessFullPath}
