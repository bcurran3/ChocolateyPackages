function Get-chocoStatus{
$chocoInstances = @(get-process -ea silentlycontinue choco).count

if($chocoInstances -eq 1){ 
    Write-Host "  ** choco.exe is currently NOT running." -foreground green
  }else{ 
    Write-Host "  ** WARNING: Found $chocoInstances instances of choco.exe running." -foreground red
  }
  
}
