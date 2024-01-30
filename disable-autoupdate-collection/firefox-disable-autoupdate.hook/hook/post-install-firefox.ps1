$ErrorActionPreference = 'Continue'
# firefox-disable-autoupdate.hook v0.1.0 Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

$HookName  = "Disable Firefox Automatic Upgrades"
$DebugInfo = $False
$DisplayInfo = $True


if ($DebugInfo) { Write-Host "  ** Running $HookName..." -Foreground Yellow }

if (!(Test-ProcessAdminRights)) {
	if ($DisplayInfo){ Write-Host "  **  $HookName requires admin rights." -Foreground Yellow}
}

if ((Get-ScheduledTask -TaskName "Firefox Background Update *" -ErrorAction SilentlyContinue).state -eq 'Ready') {
	if ($DisplayInfo) {Write-Host "  ** Disabling Firefox Background Update" -Foreground Green}
	Get-ScheduledTask -TaskName "Firefox Background Update *" | Stop-ScheduledTask | Out-Null
	Get-ScheduledTask -TaskName "Firefox Background Update *" | Disable-ScheduledTask | Out-Null
}
