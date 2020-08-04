#$ErrorActionPreference = 'Stop'
$packageName      = 'choco-package-list-backup'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir        = "$(Get-ToolsLocation)\BCURRAN3"
$script           = 'choco-package-list-backup.ps1'
$ScriptConfig     = 'choco-package-list-backup.config'
$shortcutName     = 'Chocolatey Package List Backup.lnk'
$oldshortcutName  = 'Choco Package List Backup.lnk'
$altshortcutName  = 'Package List Backup.lnk'
$Date             = Get-Date -UFormat %Y-%m-%d
$GotTask          = (&schtasks /query /tn choco-package-list-backup) 2> $null

# Setup
# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$ENV:ChocolateyToolsLocation\BCURRAN3")) { New-Item -Path "$ENV:ChocolateyToolsLocation" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Migration
# Move files before v2019.08.27 from old to new storage location
if (Test-Path "$ENV:ChocolateyInstall\bin\$script") { Remove-Item "$ENV:ChocolateyInstall\bin\$script" -Force }
if (Test-Path "$ENV:ChocolateyInstall\bin\choco-package-list-backup.xml") { Rename-Item "$ENV:ChocolateyInstall\bin\choco-package-list-backup.xml" $ScriptConfig -Force }
if (Test-Path "$ENV:ChocolateyInstall\bin\$ScriptConfig") { Move-Item "$ENV:ChocolateyInstall\bin\$ScriptConfig" "$scriptDir" -Force ; $Migration=$True }
if ($Migration) { SchTasks /Delete /TN choco-package-list-backup /F ; $GotTask=$null}

# Install Script
# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force
Move-Item "$toolsDir\choco-package-list-backup.cmd" "$scriptDir" -Force
Move-Item "$toolsDir\CPLB.cmd" "$scriptDir" -Force
if (!(Test-Path "$scriptDir\$ScriptConfig")) { Move-Item "$toolsDir\$ScriptConfig" "$scriptDir" -Force }

# Cleanup
Remove-Item "$toolsDir\choco-package-list-backup*.*" -Force -ErrorAction SilentlyContinue | Out-Null
if ($ENV:Path -NotMatch "BCURRAN3"){ Install-ChocolateyPath "$scriptDir" "Machine" ; refreshenv }

Function Update-Config{
[xml]$UpdatedConfig = Get-Content "$scriptDir\$ScriptConfig"

$UseiCloudDrive = $UpdatedConfig.Settings.Preferences.UseiCloudDrive
if ($UseiCloudDrive -eq $null)
   {
    Write-Host "  ** Adding iCloudDrive support to $ScriptConfig." -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "UseiCloudDrive", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | Out-Null
	$UpdatedFile = $True
   }
$UseownCloud = $UpdatedConfig.Settings.Preferences.UseownCloud
if ($UseownCloud -eq $null)
   {
    Write-Host "  ** Adding ownCloud support to $ScriptConfig." -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "UseownCloud", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | Out-Null
	$UpdatedFile = $True
   }
$SaveAllProgramsList = $UpdatedConfig.Settings.Preferences.SaveAllProgramsList
if ($SaveAllProgramsList -eq $null)
   {
    Write-Host "  ** Adding SaveAllProgramsList support to $ScriptConfig." -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "SaveAllProgramsList", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | Out-Null
	$UpdatedFile = $True
   }
$AllProgramsListFile = $UpdatedConfig.Settings.Preferences.AllProgramsListFile
if ($AllProgramsListFile -eq $null)
   {
    Write-Host " ** Adding AllProgramsListFile support to $ScriptConfig." -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "AllProgramsListFile", $null)
    $NewStuff.InnerText=("AllProgramsList.txt") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | Out-Null
	$UpdatedFile = $True
   }   
$SaveTitleSummary = $UpdatedConfig.Settings.Preferences.SaveTitleSummary
if ($SaveTitleSummary -eq $null)
   {
    Write-Host "  ** Adding SaveTitleSummary support to $ScriptConfig." -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "SaveTitleSummary", $null)
    $NewStuff.InnerText=("false") 
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

if ($GotTask -ne $null){
     Write-Host
     Write-Host "  ** Existing choco-package-list-backup scheduled task found:" -Foreground Magenta 
     SchTasks /query /tn "choco-package-list-backup"
     Write-Host "`nKeeping existing scheduled task and upgrading script files." -Foreground Magenta
  } else {
     SchTasks /Create /SC WEEKLY /D MON /RU SYSTEM /RL HIGHEST /TN "choco-package-list-backup" /TR "cmd /c powershell -NoProfile -ExecutionPolicy Bypass -Command %ChocolateyToolsLocation%\BCURRAN3\choco-package-list-backup.ps1" /ST 06:00 /F
     SchTasks /query /tn "choco-package-list-backup"
	 Write-Host "  ** Now configured to run choco-package-list-backup at 6 AM every MONDAY." -Foreground Green
	}
   

If (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$altshortcutName" -targetPath "$ENV:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $script" -IconLocation "$ENV:ChocolateyInstall\choco.exe" -WorkingDirectory "$ENV:ChocolateyInstall\bin\"
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$ENV:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $script" -IconLocation "$ENV:ChocolateyInstall\choco.exe" -WorkingDirectory "$ENV:ChocolateyInstall\bin\"
	}
	
Write-Host "Running choco-package-list-backup.ps1 to create backup(s)..." -Foreground Magenta
&powershell -NoProfile -ExecutionPolicy Bypass -Command "$ENV:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.ps1"
Write-Host "ADDITIONAL INFORMATION:" -Foreground Magenta
Write-Host "  ** Customize your backups by editing $ENV:ChocolateyToolsLocation\BCURRAN3\$ScriptConfig." -Foreground Magenta
Write-Host "  ** Type CHOCO-PACKAGE-LIST-BACKUP in Command Prompt or PowerShell to run." -Foreground Magenta
If (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
     Write-Host "  ** Click Package List Backup in the Start menu under Chocolatey to run." -Foreground Magenta
   } else {
     Write-Host "  ** Click Chocolatey Package List Backup in the Start menu to run." -Foreground Magenta
   }