$ErrorActionPreference = 'Stop'
$packageName      = 'choco-package-list-backup'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$pp               = Get-PackageParameters
$scriptDir        = "$(Get-ToolsLocation)\BCURRAN3"
$script           = 'choco-package-list-backup.ps1'
$ScriptConfig     = 'choco-package-list-backup.config'
$shortcutName     = 'Chocolatey Package List Backup.lnk'
$oldshortcutName  = 'Choco Package List Backup.lnk'
$altshortcutName  = 'Package List Backup.lnk'
$Date             = Get-Date -UFormat %Y-%m-%d

# Setup
# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$env:ChocolateyToolsLocation\BCURRAN3")) { New-Item -Path "$env:ChocolateyToolsLocation" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Migration
# Move files before v2019.08.27 from old to new storage location
if (Test-Path "$env:ChocolateyInstall\bin\$script") { Remove-Item "$env:ChocolateyInstall\bin\$script" -Force }
if (Test-Path "$env:ChocolateyInstall\bin\choco-package-list-backup.xml") { Rename-Item "$env:ChocolateyInstall\bin\choco-package-list-backup.xml" $ScriptConfig -Force }
if (Test-Path "$env:ChocolateyInstall\bin\$ScriptConfig") { Move-Item "$env:ChocolateyInstall\bin\$ScriptConfig" "$scriptDir" -Force ; $Migration=$True }
if ($Migration) { &SchTasks /Delete /TN choco-package-list-backup /F }
if (Test-Path "$scriptDir\choco-package-list-backup.cmd") { Remove-Item "$scriptDir\choco-package-list-backup.cmd" -Force }
if (Test-Path "$scriptDir\choco-package-list-backup-manual.bat") { Remove-Item "$scriptDir\choco-package-list-backup-manual.bat" -Force }
if (Test-Path "$scriptDir\CPLB.cmd") { Remove-Item "$scriptDir\CPLB.cmd" -Force }

# Install Script
# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force
Move-Item "$toolsDir\CPLB.bat" "$scriptDir" -Force
if (!(Test-Path "$scriptDir\$ScriptConfig")) { Move-Item "$toolsDir\$ScriptConfig" "$scriptDir" -Force }

# Create "shims"
Install-ChocolateyPowershellCommand -PackageName 'choco-package-list-backup' -PSFileFullPath "$scriptDir\$script"
Install-ChocolateyPowershellCommand -PackageName 'choco-package-list-backup' -PSFileFullPath "$scriptDir\$script"

# Cleanup
Remove-Item "$toolsDir\choco-package-list-backup.*" -Force -ErrorAction SilentlyContinue | Out-Null
if ($env:Path -NotMatch "BCURRAN3"){ Install-ChocolateyPath "$scriptDir" "Machine" ; refreshenv }

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
$DefaultUserProfile = $UpdatedConfig.Settings.Preferences.DefaultUserProfile
if ($DefaultUserProfile -eq $null)
   {
	$NewStuff=$UpdatedConfig.CreateNode("element", "DefaultUserProfile", $null)
    if ($env:COMPUTERNAME -eq $env:USERNAME.trim('$')) { $NewStuff.InnerText=('Public') } else { $NewStuff.InnerText=("$env:USERNAME") }
    Write-Host "  ** Adding DefaultUserProfile support to $ScriptConfig." -Foreground Magenta
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | Out-Null
	$UpdatedFile = $True
   }
$UseDefaultUserProfile = $UpdatedConfig.Settings.Preferences.UseDefaultUserProfile
if ($UseDefaultUserProfile -eq $null)
   {
	$NewStuff=$UpdatedConfig.CreateNode("element", "UseDefaultUserProfile", $null)
    $NewStuff.InnerText=("false") 
    Write-Host "  ** Adding UseDefaultUserProfile support to $ScriptConfig." -Foreground Magenta
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

# exit if a scheduled task is not wanted
if ($pp["NOTASK"] -eq 'true' -or $pp["NOSCHEDULE"] -eq 'true'){
       Write-Host "  ** NOTASK or NOSCHEDULE specified, not installing scheduled task." -Foreground Magenta
	   exit
   }

# install option to not run the script after install
$RunAfterInstall = $True
if ($pp["NORUN"] -eq 'true' -or $pp["DONTRUN"] -eq 'true'){
       Write-Host "  ** NORUN or DONTRUN specified, not running task." -Foreground Magenta
	   $RunAfterInstall = $False
   }

$ErrorActionPreference = 'SilentlyContinue'
$GotTask = (&schtasks /query /tn choco-package-list-backup) 2> $null
$ErrorActionPreference = 'Stop'

# Change task to run new batch file and keep other existing settings (2020.04.06 upgrade)
if ($GotTask -ne $null){
     &SchTasks /CHANGE /TN "choco-package-list-backup" /TR "%ChocolateyInstall%\bin\choco-package-list-backup.bat"
   }

if ($GotTask -ne $null){
     Write-Host
     Write-Host "  ** Existing choco-package-list-backup scheduled task found:" -Foreground Magenta 
     SchTasks /query /tn "choco-package-list-backup"
     Write-Host "`nKeeping existing scheduled task and upgrading script files." -Foreground Magenta
  } else {
     SchTasks /Create /SC WEEKLY /D MON /RU SYSTEM /RL HIGHEST /TN "choco-package-list-backup" /TR "%ChocolateyInstall%\bin\choco-package-list-backup.bat" /ST 06:00 /F
     SchTasks /query /tn "choco-package-list-backup"
	 Write-Host "  ** Now configured to run choco-package-list-backup at 6 AM every MONDAY." -Foreground Green
	}
   

If (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$altshortcutName" -targetPath "$env:ChocolateyInstall\bin\choco-package-list-backup.bat" -IconLocation "$env:ChocolateyInstall\choco.exe" -WorkingDirectory "$env:ChocolateyInstall\bin\"
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$env:ChocolateyInstall\bin\choco-package-list-backup.bat" -IconLocation "$env:ChocolateyInstall\choco.exe" -WorkingDirectory "$env:ChocolateyInstall\bin\"
	}

If ($RunAfterInstall){
	Write-Host "Running Choco-Package-List-Backup.ps1 to create backup(s)..." -Foreground Magenta
    &$env:ChocolateyInstall\bin\choco-package-list-backup.bat
   }
Write-Host "ADDITIONAL INFORMATION:" -Foreground Magenta
Write-Host "  ** Customize your backups: run CHOCO-PACKAGE-LIST-BACKUP -EDITCONFIG." -Foreground Magenta
Write-Host "  ** Run from Command Prompt or PowerShell: CHOCO-PACKAGE-LIST-BACKUP or CPLB." -Foreground Magenta
If (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
     Write-Host "  ** Run from Windows: Click Package List Backup in the Start Menu under Chocolatey to run." -Foreground Magenta
   } else {
     Write-Host "  ** Run from Windows: Click Chocolatey Package List Backup in the Start Menu to run." -Foreground Magenta
   }
