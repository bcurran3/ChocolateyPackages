$ErrorActionPreference = 'Stop'
$packageName = 'choco-cleaner'
$GotTask     = (get-scheduledtask -TaskName "choco-cleaner" -ErrorAction SilentlyContinue) 

if ($GotTask -ne $null){
   Write-Host
   Write-Host Existing "'choco-cleaner'" scheduled task found. Keeping existing scheduled task. -foreground magenta 
   Write-Host Upgrading choco-cleaner Chocolatey package files only. -foreground magenta 
   exit
   }

SchTasks /Create /SC DAILY /RU SYSTEM /RL HIGHEST /TN "choco-cleaner" /TR "Set-ExecutionPolicy Bypass -Scope Process -Force; %ChocolateyInstall%\choco-cleaner\tools\choco-cleaner.ps1" /ST 00:00 /F
Write-Host Now configured to run choco-cleaner at midnight every day. -foreground magenta
Write-Host You can run choco-cleaner manually from \ProgramData\chocolatey\lib\choco-cleaner\tools\manuallyrunchoco-cleaner.bat -foreground magenta


