$packageName = 'disablegoogleupdate-winconfig'
$GUTask1 = 'GoogleUpdateTaskMachineCore'
$GUTask2 = 'GoogleUpdateTaskMachineUA'

SchTasks /Change /Enable /TN "$GUTask1" | Out-Null
SchTasks /Change /Enable /TN "$GUTask2" | Out-Null

#Set-Service gupdate -StartupType Automatic
sc.exe config "gupdate" start=delayed-auto | Out-Null
Start-Service "gupdate" | Out-Null
Set-Service "gupdatem" -StartupType Manual | Out-Null

Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\update" -Name "updatedefault"  -ea SilentlyContinue | Out-Null
Remove-Item "HKLM:\SOFTWARE\Policies\Google\update" -force -ea SilentlyContinue | Out-Null

Write-Host "  ** Google Update re-enabled." -foreground magenta
Write-Host "  ** You're Google programs will be updated by Google Update and Chocolatey." -foreground magenta