function Get-chocoStatus{
$chocoInstances = @(Get-Process -ea silentlycontinue choco).count
# running choco got you here and is one instance!

if ($chocoInstances -gt 1)
    {
     while ($chocoInstances -gt 1)
     {
      Write-Host "  ** WARNING: Found $chocoInstances instances of choco.exe running. Pausing 15 seconds..." -foreground red
	  Start-Sleep -seconds 15
      $chocoInstances = @(Get-Process -ea silentlycontinue choco).count
     }
	} 
Write-Host "  ** choco.exe IS NOT running multiple instances." -foreground green
}


