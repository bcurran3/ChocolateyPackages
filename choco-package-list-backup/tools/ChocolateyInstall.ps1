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
[xml]$UpdatedConfig = Get-Content "$env:ChocolateyInstall\bin\$xml"

$UseiCloudDrive = $UpdatedConfig.Settings.Preferences.UseiCloudDrive
if ($UseiCloudDrive -eq $null)
   {
    Write-Host Adding iCloudDrive support to $xml. -foreground magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "UseiCloudDrive", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }
$UseownCloud = $UpdatedConfig.Settings.Preferences.UseownCloud
if ($UseownCloud -eq $null)
   {
    Write-Host Adding ownCloud support to $xml. -foreground magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "UseownCloud", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }
$SaveAllProgramsList = $UpdatedConfig.Settings.Preferences.SaveAllProgramsList
if ($SaveAllProgramsList -eq $null)
   {
    Write-Host Adding SaveAllProgramsList support to $xml. -foreground magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "SaveAllProgramsList", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }
$AllProgramsListFile = $UpdatedConfig.Settings.Preferences.AllProgramsListFile
if ($AllProgramsListFile -eq $null)
   {
    Write-Host Adding AllProgramsListFile support to $xml. -foreground magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "AllProgramsListFile", $null)
    $NewStuff.InnerText=("AllProgramsList.txt") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }   
   
if ($UpdatedFile -eq "True")
   {   
    $UpdatedConfig.Save("$env:ChocolateyInstall\bin\$xml")
	Write-Host "Updated $xml" -foreground magenta
   }
}

Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue	

if ($GotTask -ne $null){
     Write-Host
     Write-Host Existing choco-package-list-backup scheduled task found: -foreground magenta 
     SchTasks /query /tn "choco-package-list-backup"
     Write-Host Keeping existing scheduled task and upgrading script files. -foreground magenta
  } else {
     SchTasks /Create /SC WEEKLY /D MON /RU SYSTEM /RL HIGHEST /TN "choco-package-list-backup" /TR "cmd /c powershell -NoProfile -ExecutionPolicy Bypass -Command %ChocolateyInstall%\bin\choco-package-list-backup.ps1" /ST 06:00 /F
     SchTasks /query /tn "choco-package-list-backup"
	 Write-Host "Now configured to run choco-package-list-backup at 6 AM every MONDAY." -foreground green
	}
   
if (Test-Path $env:ChocolateyInstall\bin\$xml){
      Remove-Item $toolsDir\$xml -Force -ErrorAction SilentlyContinue
	  Update-Config
    } else {
	  Move-Item "$toolsDir\$xml" $env:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue
      $WhoAmI=whoami
      $Acl = Get-Acl "$env:ChocolateyInstall\bin\$xml"
      $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"FullControl","Allow")
      $Acl.SetAccessRule($Ar)
      Set-Acl "$env:ChocolateyInstall\bin\$xml" $Acl
	}
	
If (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$altshortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $script" -IconLocation $env:ChocolateyInstall\choco.exe -WorkingDirectory $env:ChocolateyInstall\bin\
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $script" -IconLocation $env:ChocolateyInstall\choco.exe -WorkingDirectory $env:ChocolateyInstall\bin\
	}
Write-Host "Running choco-package-list-backup.ps1 to create backup(s)..." -foreground magenta
&powershell -NoProfile -ExecutionPolicy Bypass -Command "$env:ChocolateyInstall\bin\choco-package-list-backup.ps1"
Write-Host "ADDITIONAL INFORMATION:" -foreground magenta
Write-Host "Edit $env:ChocolateyInstall\bin\$xml to customize your backup(s)." -foreground magenta
Write-Host "To manually backup your Chocolatey package list:" -foreground magenta
Write-Host "  Command Prompt : POWERSHELL CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground magenta
Write-Host "  PowerShell     : CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground magenta
If (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
     Write-Host "  Windows        : Click Package List Backup in the Start menu under Chocolatey" -foreground magenta
   } else {
     Write-Host "  Windows        : Click Chocolatey Package List Backup in the Start menu" -foreground magenta
   }	