#$ErrorActionPreference = 'Stop'
$packageName     = 'choco-cleaner'
#$pp              = Get-PackageParameters
$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir       = "$(Get-ToolsLocation)\BCURRAN3"
$script          = 'choco-cleaner.ps1'
$ScriptConfig    = 'choco-cleaner.config'
$shortcutName    = 'Choco Cleaner.lnk'
$altshortcutName = 'Chocolatey Cleaner.lnk'
$GotTask         = (&schtasks /query /tn choco-cleaner) 2> $null

# Setup
# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$ENV:ChocolateyToolsLocation\BCURRAN3")) { New-Item -Path "$ENV:ChocolateyToolsLocation" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Migration
# Move files before v0.0.6 from old to new storage location
if (Test-Path "$ENV:ChocolateyInstall\bin\$script") { Remove-Item "$ENV:ChocolateyInstall\bin\$script" -Force }
if (Test-Path "$ENV:ChocolateyInstall\bin\choco-cleaner.xml") { Rename-Item "$ENV:ChocolateyInstall\bin\choco-cleaner.xml" $ScriptConfig -Force }
if (Test-Path "$ENV:ChocolateyInstall\bin\$ScriptConfig") { Move-Item "$ENV:ChocolateyInstall\bin\$ScriptConfig" "$scriptDir" -Force ; $Migration=$True }
if ($Migration) { SchTasks /Delete /TN choco-cleaner /F ; $GotTask=$null}

# Install Script
# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force -ErrorAction SilentlyContinue
if (!(Test-Path "$scriptDir\$ScriptConfig")) { Move-Item "$toolsDir\$ScriptConfig" "$scriptDir" -Force }

# Cleanup
Remove-Item "$toolsDir\choco-cleaner.*" -Force -ErrorAction SilentlyContinue | Out-Null
if ($ENV:Path -NotMatch "BCURRAN3"){ Install-ChocolateyPath "$scriptDir" "Machine" ; refreshenv }

Function Update-Config{
[xml]$UpdatedConfig = Get-Content "$scriptDir\$ScriptConfig"

$DeleteNuGetCache = $UpdatedConfig.Settings.Preferences.DeleteNuGetCache
if ($DeleteNuGetCache -eq $null)
   {
    Write-Host Adding DeleteNuGetCache support to $ScriptConfig. -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "DeleteNuGetCache", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | Out-Null
	$UpdatedFile = $True
   }
   
if ($UpdatedFile)
   {   
    $UpdatedConfig.Save("$scriptDir\$ScriptConfig")
	Write-Host "  ** Updated $ScriptConfig" -Foreground Magenta
   }
}

Update-Config
Install-ChocolateyPowershellCommand -PackageName 'choco-cleaner' -PSFileFullPath "$scriptDir\$script"

#TDL (install w/o scheduled task)
#if ($pp["MANUALONLY"] -eq $null -or $pp["MANUALONLY"] -eq ''){
#       Write-Host "MANUALONLY specified, not installing scheduled task."
#     } 

if ($GotTask -ne $null){
   Write-Host
   Write-Host "  ** Existing choco-cleaner scheduled task found:" -Foreground Magenta 
   SchTasks /query /tn "choco-cleaner"
   Write-Host "`n  ** Keeping existing scheduled task and upgrading script file." -Foreground Magenta
   }

#if (Test-Path "$scriptDir\$ScriptConfig"){
#      Write-Host "Existing $ScriptConfig file found, your preferences have been saved." -Foreground Magenta
#      Remove-Item $toolsDir\$ScriptConfig -Force -ErrorAction SilentlyContinue
#    } else {
#	  Move-Item "$toolsDir\$ScriptConfig" "$scriptDir" -Force -ErrorAction SilentlyContinue
#	}
	
If (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath "$ENV:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $scriptDir\$script" -WorkingDirectory "$scriptDir" -RunAsAdmin
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName" -targetPath "$ENV:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $scriptDir\$script" -WorkingDirectory "$scriptDir" -RunAsAdmin
	}	
if ($GotTask -ne $null){ exit }
SchTasks /Create /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN "choco-cleaner" /TR "cmd /c powershell -NoProfile -ExecutionPolicy Bypass -Command %ChocolateyToolsLocation%\BCURRAN3\choco-cleaner.ps1" /ST 23:00 /F
SchTasks /query /tn "choco-cleaner"
Write-Host "Now configured to run choco-cleaner at 11:00 PM every SUNDAY." -Foreground Green
Write-Host "You can manually run choco-cleaner from the Command Prompt and Powershell." -Foreground Magenta
#Write-Host "WINDOWS START MENU: click the Chocolatey Cleaner icon. If you have choco-shortcuts-winconfig installed you'll find Choco Cleaner with the rest of the Chocolatey shortcuts." -Foreground Magenta


