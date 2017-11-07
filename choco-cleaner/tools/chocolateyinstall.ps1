$ErrorActionPreference = 'Stop'
$packageName = 'choco-cleaner'
$GotTask     = (get-scheduledtask -TaskName "choco-cleaner" -ErrorAction SilentlyContinue) 

if ($GotTask -ne $null){
   Write-Host
   Write-Host Existing "'choco-cleaner'" scheduled task found. Keeping existing scheduled task. -foreground magenta 
   Write-Host Upgrading choco-cleaner Chocolatey package files only. -foreground magenta 
   exit
   }

SchTasks /Create /SC DAILY /RU SYSTEM /RL HIGHEST /TN "choco-cleaner" /TR "cmd /c powershell -NoProfile -ExecutionPolicy Bypass -Command %ChocolateyInstall%\lib\choco-cleaner\tools\choco-cleaner.ps1" /ST 23:30 /F
Write-Host Now configured to run choco-cleaner at 11:30 PM every day. Do NOT run Chocolatey upgrades at this time! -foreground magenta
Write-Host You can run choco-cleaner manually from \ProgramData\chocolatey\lib\choco-cleaner\tools\choco-cleaner-manual.bat -foreground magenta


