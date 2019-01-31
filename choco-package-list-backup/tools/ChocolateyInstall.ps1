$ErrorActionPreference = 'Stop'
$packageName      = 'choco-package-list-backup'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$Date             = Get-Date -UFormat %Y-%m-%d
$script           = 'choco-package-list-backup.ps1'
$xml              = 'choco-package-list-backup.xml'
$shortcutName     = 'Chocolatey Package List Backup.lnk'
$oldshortcutName  = 'Choco Package List Backup.lnk'
$altshortcutName  = 'Package List Backup.lnk'
$GotTask          = (&schtasks /query /tn choco-package-list-backup) 2> $null

Function Update-Config{
[xml]$UpdatedConfig = Get-Content "$ENV:ChocolateyInstall\bin\$xml"

$UseiCloudDrive = $UpdatedConfig.Settings.Preferences.UseiCloudDrive
if ($UseiCloudDrive -eq $null)
   {
    Write-Host Adding iCloudDrive support to $xml. -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "UseiCloudDrive", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }
$UseownCloud = $UpdatedConfig.Settings.Preferences.UseownCloud
if ($UseownCloud -eq $null)
   {
    Write-Host Adding ownCloud support to $xml. -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "UseownCloud", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }
$SaveAllProgramsList = $UpdatedConfig.Settings.Preferences.SaveAllProgramsList
if ($SaveAllProgramsList -eq $null)
   {
    Write-Host Adding SaveAllProgramsList support to $xml. -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "SaveAllProgramsList", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }
$AllProgramsListFile = $UpdatedConfig.Settings.Preferences.AllProgramsListFile
if ($AllProgramsListFile -eq $null)
   {
    Write-Host Adding AllProgramsListFile support to $xml. -Foreground Magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "AllProgramsListFile", $null)
    $NewStuff.InnerText=("AllProgramsList.txt") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }   
   
if ($UpdatedFile -eq "True")
   {   
    $UpdatedConfig.Save("$ENV:ChocolateyInstall\bin\$xml")
	Write-Host "Updated $xml" -Foreground Magenta
   }
}

Move-Item "$toolsDir\$script" $ENV:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue	

if ($GotTask -ne $null){
     Write-Host
     Write-Host Existing choco-package-list-backup scheduled task found: -Foreground Magenta 
     SchTasks /query /tn "choco-package-list-backup"
     Write-Host Keeping existing scheduled task and upgrading script files. -Foreground Magenta
  } else {
     SchTasks /Create /SC WEEKLY /D MON /RU SYSTEM /RL HIGHEST /TN "choco-package-list-backup" /TR "cmd /c powershell -NoProfile -ExecutionPolicy Bypass -Command %ChocolateyInstall%\bin\choco-package-list-backup.ps1" /ST 06:00 /F
     SchTasks /query /tn "choco-package-list-backup"
	 Write-Host "Now configured to run choco-package-list-backup at 6 AM every MONDAY." -Foreground Green
	}
   
if (Test-Path $ENV:ChocolateyInstall\bin\$xml){
      Remove-Item $toolsDir\$xml -Force -ErrorAction SilentlyContinue
	  Update-Config
    } else {
	  Move-Item "$toolsDir\$xml" $ENV:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue
      $WhoAmI=whoami
      $Acl = Get-Acl "$ENV:ChocolateyInstall\bin\$xml"
      $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"FullControl","Allow")
      $Acl.SetAccessRule($Ar)
      Set-Acl "$ENV:ChocolateyInstall\bin\$xml" $Acl
	}
	
If (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Remove-Item "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$altshortcutName" -targetPath "$ENV:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $script" -IconLocation $ENV:ChocolateyInstall\choco.exe -WorkingDirectory $ENV:ChocolateyInstall\bin\
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$ENV:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $script" -IconLocation $ENV:ChocolateyInstall\choco.exe -WorkingDirectory $ENV:ChocolateyInstall\bin\
	}
Write-Host "Running choco-package-list-backup.ps1 to create backup(s)..." -Foreground Magenta
&powershell -NoProfile -ExecutionPolicy Bypass -Command "$ENV:ChocolateyInstall\bin\choco-package-list-backup.ps1"
Write-Host "ADDITIONAL INFORMATION:" -Foreground Magenta
Write-Host "  * Edit $ENV:ChocolateyInstall\bin\$xml to customize your backup(s)." -Foreground Magenta
Write-Host "  * To manually backup your Chocolatey package list:" -Foreground Magenta
Write-Host "       Command Prompt - POWERSHELL CHOCO-PACKAGE-LIST-BACKUP.PS1" -Foreground Magenta
Write-Host "       PowerShell     - CHOCO-PACKAGE-LIST-BACKUP.PS1" -Foreground Magenta
If (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
     Write-Host "       Windows        - Click Package List Backup in the Start menu under Chocolatey" -Foreground Magenta
   } else {
     Write-Host "       Windows        - Click Chocolatey Package List Backup in the Start menu" -Foreground Magenta
   }