$packageName = 'disablegoogleupdate-winconfig'

Set-Location -Path $env:windir\System32\Tasks 
Get-ScheduledTask GoogleUpdate* |Disable-ScheduledTask | Out-Null

Stop-Service "gupdate" | Out-Null
Stop-Service "gupdatem" | Out-Null
Set-Service "gupdate" -StartupType Disabled | Out-Null
Set-Service "gupdatem" -StartupType Disabled | Out-Null

New-Item "HKLM:\SOFTWARE\Policies\Google" -force -ea SilentlyContinue | Out-Null
New-Item "HKLM:\SOFTWARE\Policies\Google\update" -force -ea SilentlyContinue | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Update" -Name "AutoUpdateCheckPeriodMinutes" -Value "0" -force -ea SilentlyContinue | Out-Null
#New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Update" -Name "UpdateDefault" -Value "0" -force -ea SilentlyContinue | Out-Null

Get-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run | Remove-ItemProperty -Name "Google Update" -ea SilentlyContinue | Out-Null

Write-Host "  ** Google Update disabled." -foreground magenta
Write-Host "  ** You're Google programs will be updated by Chocolatey only." -foreground magenta
