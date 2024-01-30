$ErrorActionPreference = 'Continue'
# dropbox-disable-autoupdate.hook v0.1.0 Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

$HookName  = "Disable Dropbox Automatic Upgrades"
$DebugInfo = $False
$DisplayInfo = $True


if ($DebugInfo) { Write-Host "  ** Running $HookName..." -Foreground Yellow }

if (!(Test-ProcessAdminRights)) {
	if ($DisplayInfo){ Write-Host "  **  $HookName requires admin rights." -Foreground Yellow}
}

if ((Get-ScheduledTask -TaskName 'DropboxUpdateTaskMachineCore' -ErrorAction SilentlyContinue).state -eq 'Ready') {
	if ($DisplayInfo) {Write-Host "  ** Disabling DropboxUpdateTaskMachineCore" -Foreground Green}
	Stop-ScheduledTask -TaskName 'DropboxUpdateTaskMachineCore' | Out-Null
	Disable-ScheduledTask -TaskName 'DropboxUpdateTaskMachineCore' | Out-Null
}

if ((Get-ScheduledTask -TaskName 'DropboxUpdateTaskMachineUA' -ErrorAction SilentlyContinue).state -eq 'Ready') {
	if ($DisplayInfo) {Write-Host "  ** Disabling DropboxUpdateTaskMachineUA" -Foreground Green}
	Stop-ScheduledTask -TaskName 'DropboxUpdateTaskMachineUA' | Out-Null
	Disable-ScheduledTask -TaskName 'DropboxUpdateTaskMachineUA' | Out-Null
}
