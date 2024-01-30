$ErrorActionPreference = 'Stop'
$packageName  = 'jellyfin'
$ShortcutName = 'Jellyfin'

Remove-Item "$ENV:Public\Desktop\$ShortcutName.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -Force -ErrorAction SilentlyContinue

if (Test-Path "$ENV:LOCALAPPDATA\jellyfin") {
    Write-Host "  ** Found $ENV:LOCALAPPDATA\jellyfin data directory." -Foreground Magenta
	Write-Host "  ** Manually delete it if you no longer want the data." -Foreground Magenta
	}
