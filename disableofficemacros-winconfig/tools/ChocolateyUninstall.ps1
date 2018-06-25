$packageName = 'disableofficemacros-winconfig'

# Office 2013
if (Test-Path -Path "HKCU:\Software\Policies\Microsoft\Office\15.0")
    {
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Access\Security" -Name "VBAWarnings" -ea SilentlyContinue
     Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Excel\Security" -Name "VBAWarnings" -ea SilentlyContinue
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Outlook\Security" -Name "level" -ea SilentlyContinue
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\PowerPoint\Security" -Name "VBAWarnings" -ea SilentlyContinue
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\MS Project\Security" -Name "VBAWarnings" -ea SilentlyContinue
     Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Publisher\Security" -Name "VBAWarnings" -ea SilentlyContinue
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Word\Security" -Name "VBAWarnings" -ea SilentlyContinue
	 Write-Host "** Removing Office 2013 macro security settings. **" -foreground magenta
    }

# Office 2016
if (Test-Path -Path "HKCU:\Software\Policies\Microsoft\Office\16.0")
    {
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Access\Security" -Name "VBAWarnings" -ea SilentlyContinue
     Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Excel\Security" -Name "VBAWarnings" -ea SilentlyContinue
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Outlook\Security" -Name "level" -ea SilentlyContinue
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint\Security" -Name "VBAWarnings" -ea SilentlyContinue
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\MS Project\Security" -Name "VBAWarnings" -ea SilentlyContinue	 
     Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Publisher\Security" -Name "VBAWarnings" -ea SilentlyContinue
	 Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Word\Security" -Name "VBAWarnings" -ea SilentlyContinue
	 Write-Host "** Removing Office 2016 macro security settings. **" -foreground magenta
    }
