$packageName = 'disabledefender-winconfig'

# Windows 7
If (Get-IsWin7)
   {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\WinDefend" -Name "Start" -Value 4 -Type DWord -Force
	Write-Host Windows Defender service disabled. -foreground magenta
	exit
   }

# Windows 8 & 10
if (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware")
    {
     Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Type DWord -Force
    } else {
#      New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Type DWord -Force
	  Write-Host Windows Defender disabled. -foreground magenta
	}
	   