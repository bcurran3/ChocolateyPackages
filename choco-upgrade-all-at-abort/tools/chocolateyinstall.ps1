$ErrorActionPreference = 'Stop'
$packageName = 'choco-upgrade-all-at-abort'
$pp          = Get-PackageParameters
   
Write-Host "" 
Write-Host "choco-upgrade-all-at-abort Summary:" -foreground magenta

if ($pp["ABORTTIME"] -eq $null -or $pp["ABORTTIME"] -eq ''){
      Write-Host " * ABORTTIME NOT specified, defaulting to 04:00." -foreground magenta
	  $AbortTime = "04:00"
    } else {
	  $AbortTime = $pp["ABORTTIME"]
	  Write-Host " * ABORTTIME specified as $AbortTime." -foreground magenta
    } 
SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
SchTasks /query /tn "choco-upgrade-all-at-abort"
