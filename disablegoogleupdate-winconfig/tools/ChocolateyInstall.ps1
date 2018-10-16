$packageName = 'disablegoogleupdate-winconfig'
$GUTask1 = 'GoogleUpdateTaskMachineCore'
$GUTask2 = 'GoogleUpdateTaskMachineUA'

SchTasks /Change /Disable /TN "$GUTask1" | Out-Null
SchTasks /Change /Disable /TN "$GUTask2" | Out-Null

Stop-Service "gupdate" | Out-Null
Stop-Service "gupdatem" | Out-Null
Set-Service "gupdate" -StartupType Disabled | Out-Null
Set-Service "gupdatem" -StartupType Disabled | Out-Null

New-Item "HKLM:\SOFTWARE\Policies\Google" -force -ea SilentlyContinue | Out-Null
New-Item "HKLM:\SOFTWARE\Policies\Google\update" -force -ea SilentlyContinue | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\update" -Name "updatedefault" -Value "0"-force -ea SilentlyContinue | Out-Null

Write-Host "  ** Google Update disabled." -foreground magenta
Write-Host "  ** You're Google programs will be updated by Chocolatey only." -foreground magenta

# Might have to check and disable scheduled task under user profile