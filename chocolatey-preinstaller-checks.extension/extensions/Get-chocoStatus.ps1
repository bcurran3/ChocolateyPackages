# chocolatey-preinstaller-checks.extension v0.0.2 by Bill Curran AKA BCURRAN3 - 2018 public domain
# Get-chocoStatus.ps1 - checks for multiple instances of Chocolatey running and warns or aborts
# See/Edit Chocolatey-Preinstaller-Checks.xml for options
# If this extension stops your packages from becoming lost and unmanaged, consider becoming a patron of me at https://www.patreon.com/bcurran3 :)

function Get-chocoStatus{

# Import preferences
$xml              = 'Chocolatey-Preinstaller-Checks.xml'  
[xml]$ConfigFile  = Get-Content "$env:ChocolateyInstall\extensions\chocolatey-preinstaller-checks\$xml"  
$AbortOnMultiples = $ConfigFile.Settings.global.AbortOnMultiples
$WaitOnMultiple   = $ConfigFile.Settings.chocoStatus.WaitOnMultiple
$PauseSeconds     = $ConfigFile.Settings.chocoStatus.PauseSeconds
$AbortSeconds     = $ConfigFile.Settings.chocoStatus.AbortSeconds

$chocoInstances = (Get-chocoInstanceCounts)

if ($chocoInstances -gt 2)
    {
	 # exclude current instance from status report
     while ($chocoInstances -gt 1)
     {
	  If ($AbortOnMultiples -eq $true)
          {
	       Write-Host "  * WARNING: $($chocoInstances-1) other instance(s) of choco.exe actual found running. Aborting install of $env:packageName!" -foreground red
		   $global:CPCEAbort = $true
		   return
	      }
	  If ($WaitOnMultiple -eq $false)
          {
	       Write-Host "  * WARNING: $($chocoInstances-1) other instance(s) of choco.exe actual found running." -foreground red
		   return
	      }
      Write-Host "  * WARNING: $($chocoInstances-1) other instance(s) of choco.exe actual found running. Pausing $PauseSeconds seconds..." -foreground red
	  Start-Sleep -seconds $PauseSeconds
      $chocoInstances = (Get-chocoInstanceCounts)
	 }
    } else {
	  Write-Host "  * choco.exe IS NOT running multiple instances." -foreground green
	}
}

