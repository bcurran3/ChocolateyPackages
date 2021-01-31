#$ErrorActionPreference = 'Stop'
$packageName     = 'choco-cleaner'
$pp              = Get-PackageParameters
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
if (Test-Path "$ENV:ChocolateyInstall\bin\$ScriptConfig") { Move-Item "$ENV:ChocolateyInstall\bin\$ScriptConfig" "$scriptDir" -Force ; SchTasks /Delete /TN choco-cleaner /F ; $GotTask=$null}

# Install Script
# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force -ErrorAction SilentlyContinue
if (!(Test-Path "$scriptDir\$ScriptConfig")) { Move-Item "$toolsDir\$ScriptConfig" "$scriptDir" -Force }

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
Install-ChocolateyPowershellCommand -PackageName 'choco-cleaner' -PSFileFullPath "$scriptDir\$script"

If (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath "$ENV:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $scriptDir\$script" -WorkingDirectory "$scriptDir" -IconLocation "$toolsDir\choco-cleaner.ico" -RunAsAdmin
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName" -targetPath "$ENV:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $scriptDir\$script" -WorkingDirectory "$scriptDir" -IconLocation "$toolsDir\choco-cleaner.ico" -RunAsAdmin
	}

if ($pp["NOTASK"] -eq 'true' -or $pp["NOSCHEDULE"] -eq 'true'){
       Write-Host "  ** NOTASK or NOSCHEDULE specified, not installing scheduled task." -Foreground Magenta
	   if ($GotTask -ne $null){
          Write-Host "  ** Removing existing choco-cleaner scheduled task." -Foreground Magenta 
          SchTasks /Delete /TN “choco-cleaner” /F
	   }
    } else {
      if ($GotTask -ne $null){
          Write-Host "`n  ** Existing choco-cleaner scheduled task found:" -Foreground Magenta 
          SchTasks /query /tn "choco-cleaner"
          Write-Host "`n  ** Keeping existing scheduled task." -Foreground Magenta
        } else {
          SchTasks /Create /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN "choco-cleaner" /TR "cmd /c powershell -NoProfile -ExecutionPolicy Bypass -Command %ChocolateyToolsLocation%\BCURRAN3\choco-cleaner.ps1" /ST 23:00 /F
          SchTasks /query /tn "choco-cleaner"
		  Write-Host "Now configured to run choco-cleaner at 11:00 PM every SUNDAY." -Foreground Green
		}
	}
Write-Host "You can manually run choco-cleaner from the Command Prompt, Powershell, or the Windows Start Menu icon." -Foreground Magenta
