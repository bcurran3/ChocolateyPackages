$ErrorActionPreference = 'Continue'
# opera-disable-autoupdate.hook v0.1.0 Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

$HookName  = "Disable Opera Automatic Upgrades"
$DebugInfo = $False
$DisplayInfo = $True


if ($DebugInfo) { Write-Host "  ** Running $HookName..." -Foreground Yellow }

if (!(Test-ProcessAdminRights)) {
	if ($DisplayInfo){ Write-Host "  **  $HookName requires admin rights." -Foreground Yellow}
}

if ((Get-ScheduledTask -TaskName "Opera scheduled assistant Autoupdate *" | Out-Null -ErrorAction SilentlyContinue).state -eq 'Ready') {
	if ($DisplayInfo) {Write-Host "  ** Disabling Opera scheduled Autoupdate" -Foreground Green}
	Get-ScheduledTask -TaskName "Opera scheduled Autoupdate *" | Stop-ScheduledTask | Out-Null
	Get-ScheduledTask -TaskName "Opera scheduled Autoupdate *" | Disable-ScheduledTask | Out-Null
}

if ((Get-ScheduledTask -TaskName "Opera scheduled assistant Autoupdate *" | Out-Null -ErrorAction SilentlyContinue).state -eq 'Ready') {
	if ($DisplayInfo) {Write-Host "  ** Disabling Opera scheduled assistant Autoupdate" -Foreground Green}
	Get-ScheduledTask -TaskName "Opera scheduled assistant Autoupdate *" | Stop-ScheduledTask | Out-Null
	Get-ScheduledTask -TaskName "Opera scheduled assistant Autoupdate *" | Disable-ScheduledTask | Out-Null
}

