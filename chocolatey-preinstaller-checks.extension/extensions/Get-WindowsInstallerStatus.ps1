# chocolatey-preinstaller-checks.extension v0.0.2-pre01 by Bill Curran AKA BCURRAN3 - 2018 public domain
# Get-WindowsInstallerStatus.ps1 - checks for multiple instances of Windows Installer running and warns or aborts
# See/Edit Chocolatey-Preinstaller-Checks.xml for options
# If this extension stops your packages from becoming lost and unmanaged,
# consider becoming a patron of me at https://www.patreon.com/bcurran3 :)

function Get-WindowsInstallerStatus{
$msiexecInstances = @(Get-Process -ea silentlycontinue msiexec).count

# Import preferences
$xml   = 'Chocolatey-Preinstaller-Checks.xml'  
[xml]$ConfigFile = Get-Content "$env:ChocolateyInstall\extensions\chocolatey-preinstaller-checks\$xml"  
$AbortOnMultiples= $ConfigFile.Settings.global.AbortOnMultiples
$WaitOnMultiple  = $ConfigFile.Settings.WindowsInstallerStatus.WaitOnMultiple
$PauseSeconds    = $ConfigFile.Settings.WindowsInstallerStatus.PauseSeconds

if ($msiexecInstances -gt 1)
   {
    while ($msiexecInstances -gt 1)
	{
     If ($AbortOnMultiples -eq "true")
         {
	      Write-Host "  * WARNING: Windows Installer IS currently running. Aborting install of $env:packageName!" -foreground red
	      $global:CPCEAbort = "true"
	      return
	     }
     If ($WaitOnMultiple -eq "false")
	     {
	      Write-Host "  * WARNING: Windows Installer IS currently running" -foreground red
	      return
	     } 	
     Write-Host "  * WARNING: Windows Installer IS currently running. Pausing $PauseSeconds seconds..." -foreground red
	 Start-Sleep -seconds $PauseSeconds
     $msiexecInstances = @(Get-Process -ea silentlycontinue msiexec).count
	}
   } else {
     Write-Host "  * Windows Installer IS NOT currently running" -foreground green
	}
}
