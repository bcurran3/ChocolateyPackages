$ErrorActionPreference = 'Stop'
$packageName = 'choco-persistent-packages-abort'
$pp          = Get-PackageParameters
   
Write-Host "" 
Write-Host "choco-persistent-packages-abort Summary:" -foreground magenta

if ($pp["ABORTTIME"] -eq $null -or $pp["ABORTTIME"] -eq ''){
      Write-Host " * ABORTTIME NOT specified, defaulting to 01:30." -foreground magenta
	  $AbortTime = "01:30"
    } else {
	  $AbortTime = $pp["ABORTTIME"]
	  Write-Host " * ABORTTIME specified as $AbortTime." -foreground magenta
    } 
SchTasks /CREATE /SC DAILY /RU SYSTEM /RL HIGHEST /TN choco-persistent-packages-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
SchTasks /query /tn choco-persistent-packages-abort
