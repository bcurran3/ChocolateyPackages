function Get-chocoStatus($AllowedChocos){
$chocoInstances = @(Get-Process -ea silentlycontinue choco).count
# running choco got you here and is one instance!
# install causes one instance
# uninstall seems to always cause two instances

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


