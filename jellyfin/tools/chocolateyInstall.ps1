$ErrorActionPreference = 'Stop'
$version = "v$ENV:ChocolateyPackageVersion"
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ShortcutName = 'Jellyfin'

if (Test-Path $ENV:ChocolateyToolsLocation\jellyfin) {
  Write-Host "  ** You are upgrading from Jellyfin v10.3.7 PORTABLE." -Foreground Magenta
	Write-Host "  ** According to the Jellyfin installation instructions:" -Foreground Magenta
	Write-Host "  ** ""When using the installer, please ensure you fully uninstall any ZIP archive versions you may have installed," -Foreground Magenta
	Write-Host "      or you may get duplicate services."""  -Foreground Magenta
	Write-Host "  ** Please remove $ENV:ChocolateyToolsLocation\jellyfin and install Jellyfin again. Unfortunately you'll also have to configure it again." -Foreground Magenta
	Uninstall-BinFile 'jellyfin'
	throw
}

$packageArgs = @{
  packageName    = 'jellyfin'
  fileType       = 'EXE'
  url64bit       = "https://github.com/jellyfin/jellyfin/releases/download/$version/jellyfin_$version-x64_windows.exe"
  checksum64     = '96985faba67f2e3fc0ffa76a4e44ab1b0a274e7feb9860c02db7f6dc254abb30'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0,1)
  softwareName   = 'Jellyfin Server*'
}
 
Install-ChocolateyPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$ShortcutName.lnk" -targetPath "http://localhost:8096" -IconLocation "$ENV:ProgramFiles\Jellyfin\Server\jellyfin-web\favicon.ico"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "http://localhost:8096" -IconLocation "$ENV:ProgramFiles\Jellyfin\Server\jellyfin-web\favicon.ico"

Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null
Remove-Item $toolsDir\*.ignore -EA SilentlyContinue | Out-Null
