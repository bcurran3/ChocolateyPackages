$ErrorActionPreference = 'Stop'
$packageName  = 'choco-upgrade-all-startup'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir    = "$(Get-ToolsLocation)\BCURRAN3"
$script       = 'choco-upgrade-all.ps1'
$ScriptConfig = 'choco-upgrade-all.config'

# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$ENV:ChocolateyToolsLocation\BCURRAN3")) { New-Item -Path "$ENV:ChocolateyToolsLocation" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force -ErrorAction SilentlyContinue
Move-Item "$toolsDir\choco-install.ps1" "$scriptDir" -Force -ErrorAction SilentlyContinue
if (!(Test-Path "$scriptDir\$ScriptConfig")) { Move-Item "$toolsDir\$ScriptConfig" "$scriptDir" -Force }

# Create "shim"
Install-ChocolateyPowershellCommand -PackageName 'choco-upgrade-all' -PSFileFullPath "$scriptDir\$script"
Install-ChocolateyPowershellCommand -PackageName 'choco-install' -PSFileFullPath "$scriptDir\choco-install.ps1"

# Cleanup
Remove-Item "$toolsDir\choco-upgrade-all.*" -Force -ErrorAction SilentlyContinue | Out-Null
if ($ENV:Path -NotMatch "BCURRAN3"){ Install-ChocolateyPath "$scriptDir" "Machine" ; refreshenv }

# delete old task name if it exists from older versions
$GotTask     = (get-scheduledtask -TaskName "Run a Choco Upgrade All at Startup" -ErrorAction SilentlyContinue)
if ($GotTask -ne $null){
    &SCHTASKS.exe /DELETE /TN "Run a Choco Upgrade All at Startup" /F
   }
   
# always delete task to make sure it is current
$GotTask     = (get-scheduledtask -TaskName "choco-upgrade-all-startup" -ErrorAction SilentlyContinue)
if ($GotTask -ne $null){
    &SCHTASKS.exe /DELETE /TN "Run a Choco Upgrade All at Startup" /F
   }

# create new scheduled task to run at startup   
SchTasks /Create /SC ONSTART /RU SYSTEM /RL HIGHEST /TN "choco-upgrade-all-startup" /TR "cmd /c powershell -NoProfile -ExecutionPolicy Bypass -Command %ChocolateyToolsLocation%\BCURRAN3\choco-upgrade-all.ps1" /F
Write-Host "Now configured to run ""choco upgrade all -y"" at Windows startup." -Foreground Magenta 
