$ErrorActionPreference = 'Stop'
$packageName     = 'choco-cleaner'
$pp              = Get-PackageParameters
$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir       = "$(Get-ToolsLocation)\BCURRAN3"
$script          = 'choco-cleaner.ps1'
$ScriptConfig    = 'choco-cleaner.config'
$shortcutName    = 'Choco Cleaner.lnk'
$altshortcutName = 'Chocolatey Cleaner.lnk'

# Setup
# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$ENV:ChocolateyToolsLocation\BCURRAN3")) { New-Item -Path "$ENV:ChocolateyToolsLocation" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Migration
# Move files before v0.0.6 from old to new storage location
if (Test-Path "$ENV:ChocolateyInstall\bin\$script") { Remove-Item "$ENV:ChocolateyInstall\bin\$script" -Force }
if (Test-Path "$ENV:ChocolateyInstall\bin\choco-cleaner.xml") { Rename-Item "$ENV:ChocolateyInstall\bin\choco-cleaner.xml" $ScriptConfig -Force }
if (Test-Path "$ENV:ChocolateyInstall\bin\$ScriptConfig") { Move-Item "$ENV:ChocolateyInstall\bin\$ScriptConfig" "$scriptDir" -Force}

# Install Script
# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force -ErrorAction SilentlyContinue
if (!(Test-Path "$scriptDir\$ScriptConfig")) { Move-Item "$toolsDir\$ScriptConfig" "$scriptDir" -Force }

# Create "shim"
Install-ChocolateyPowershellCommand -PackageName 'choco-cleaner' -PSFileFullPath "$scriptDir\$script"

# Cleanup
Remove-Item "$toolsDir\choco-cleaner.*" -Exclude choco-cleaner.ico -Force -ErrorAction SilentlyContinue | Out-Null
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

# Create Start Menu icon
If (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath "$env:ChocolateyInstall\bin\choco-cleaner.bat" -IconLocation "$toolsDir\choco-cleaner.ico" -RunAsAdmin
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName" -targetPath "$env:ChocolateyInstall\bin\choco-cleaner.bat" -IconLocation "$toolsDir\choco-cleaner.ico" -RunAsAdmin
	}

# Remove previous scheduled task to fix v0.0.6 - v0.0.8 scheduled task execution bug
$ErrorActionPreference = 'SilentlyContinue'
$GotTask = (&schtasks /query /tn choco-cleaner) 2> $null
$ErrorActionPreference = 'Stop'
if ($GotTask -ne $null){&SchTasks /DELETE /TN "choco-cleaner" /F}

if ($pp["NOTASK"] -eq 'true' -or $pp["NOSCHEDULE"] -eq 'true'){
       Write-Host "  ** NOTASK or NOSCHEDULE specified, not installing scheduled task." -Foreground Magenta
	   Write-Host "You can manually run Choco-Cleaner from the Command Prompt, Powershell, or the Windows Start Menu icon." -Foreground Magenta
	   exit
   }

# Create scheduled task
SchTasks /Create /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN "choco-cleaner" /TR "%ChocolateyInstall%\bin\choco-cleaner.bat" /ST 23:00 /F
SchTasks /query /tn "choco-cleaner"
Write-Host "Now configured to run Choco-Cleaner at 11:00 PM every SUNDAY." -Foreground Green
Write-Host "You can manually run Choco-Cleaner from the Command Prompt, Powershell, or the Windows Start Menu icon." -Foreground Magenta
