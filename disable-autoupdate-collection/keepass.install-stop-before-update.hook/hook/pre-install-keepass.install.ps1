$ErrorActionPreference = 'Continue'
# dropbox-disable-autoupdate.hook v0.1.0 Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

$HookName  = "Disable Dropbox Automatic Upgrades"
$DebugInfo = $True


if ($DebugInfo) { Write-Host "  ** Running $HookName..." -Foreground Yellow }

if (Test-ProcessAdminRights) {

    Write-Host "DEBUG/TEST: This should run only when the dropbox package gets installed or updated." -Foreground Red

# disable DropboxUpdateTaskMachineCore and DropboxUpdateTaskMachineUA  tasks

} else {
	if ($DisplayInfo){ Write-Host "$HookName requires admin rights." }
}
