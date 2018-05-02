$packageName = 'disabledefender-winconfig'

# Windows 7
If (Get-IsWin7)
   {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\WinDefend" -Name "Start" -Value 2 -Type DWord -Force
	Write-Host Windows Defender service enabled. -foreground magenta
	exit
   }
   
# Windows 8 & 10
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 0 -Type DWord -Force
Write-Host Windows Defender enabled. -foreground magenta

	   