$ErrorActionPreference = 'Stop'
$packageName  = 'choco-optimize-at'
$pp           = Get-PackageParameters
$CheckLicense = "$env:ChocolateyInstall\license\chocolatey.license.xml"

if (Test-Path $CheckLicense){
    Write-Host Chocolatey license file found. Thanks for supporting Chocolatey! -foreground green
    } else {
      Write-Host Chocolatey license file NOT found. You need to be a Chocolatey Pro or Business customer to use this package. See https://chocolatey.org/pricing for more information. -foreground red
	  throw
    }
  
Write-Host "choco-optimize-at Summary:" -foreground magenta

if ($pp["TIME"] -eq $null -or $pp["TIME"] -eq ''){
      Write-Host " * TIME NOT specified, defaulting to 5 AM." -foreground magenta
	  $RunTime = "05:00"
    } else {
	  $RunTime = $pp["TIME"]
	  Write-Host " * TIME specified as $TIME." -foreground magenta
    } 
	
if (($pp["DAILY"] -eq $null -or $pp["DAILY"] -eq '') -and ($pp["WEEKLY"] -eq $null -or $pp["WEEKLY"] -eq '')){
      Write-Host " * DAILY NOT specified." -foreground magenta
      Write-Host " * WEEKLY NOT specified." -foreground magenta	  
      Write-Host " * Defaulting to WEEKLY running of ""choco-optimize-at"" at $RunTime on Sundays." -foreground magenta -background blue
      SchTasks /CREATE /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN choco-optimize-at /TR "choco optimize" /ST $RunTime /F
	  SchTasks /query /tn choco-optimize-at
 	  exit
    }
		  
if ($pp["DAILY"] -eq $null -or $pp["DAILY"] -eq ''){
       Write-Host " * DAILY NOT specified." -foreground magenta
    } else {
	   Write-Host " * DAILY specified." -foreground magenta
	   SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-optimize-at /TR "choco optimize" /ST $RunTime /F
	   SchTasks /query /tn choco-optimize-at
	   exit
	   }
		  
if ($pp["WEEKLY"] -eq $null -or $pp["WEEKLY"] -eq ''){
       Write-Host " * WEEKLY NOT specified." -foreground magenta
     } else {
	   Write-Host " * WEEKLY specified." -foreground magenta
       if ($pp["DAY"] -eq $null -or $pp["DAY"] -eq ''){
            Write-Host " * DAY NOT specified, defaulting to SUNDAY." -foreground magenta
            SchTasks /CREATE /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN choco-optimize-at /TR "choco optimize" /ST $RunTime /F
        } else {
		    $RunDay = $pp["DAY"]
            Write-Host " * DAY specified as $RunDay." -foreground magenta
		    SchTasks /CREATE /SC WEEKLY /D $pp["DAY"] /RU SYSTEM /RL HIGHEST /TN choco-optimize-at /TR "choco optimize" /ST $RunTime /F
			SchTasks /query /tn "choco-optimize-at"
	    }
	}
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-optimize-at /TR "choco optimize" /ST $TIME /F
SchTasks /query /tn choco-optimize-at
