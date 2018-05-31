function Get-chocoStatus($AllowedChocos){
$chocoInstances = @(Get-Process -ea silentlycontinue choco).count
$CheckLicense = "$env:ChocolateyInstall\license\chocolatey.license.xml"
# running choco got you here and is one instance!
# install causes one instance
# uninstall seems to always cause two instances
# choco-agent reports as choco.exe per gep13?? Unknown, can't test. 

if((get-process "choco-agent" -ea SilentlyContinue) -eq $Null){
    } else {
    Write-Host "  * choco-agent.exe found running, can't effectively check for multiple instances at this time. (Sorry!) " -foreground yellow
	break
  }

if ($chocoInstances -gt $AllowedChocos)
    {
     while ($chocoInstances -gt $AllowedChocos)
     {
      Write-Host "  * WARNING: Found multiple instances of choco.exe running. Pausing 30 seconds..." -foreground red
	  Start-Sleep -seconds 30
      $chocoInstances = @(Get-Process -ea silentlycontinue choco).count
     }
	} 
Write-Host "  * choco.exe IS NOT running multiple instances." -foreground green
}

