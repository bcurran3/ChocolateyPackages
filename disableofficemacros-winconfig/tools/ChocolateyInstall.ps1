$packageName = 'disableofficemacros-winconfig'

# Office 2013
if (Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0")
    {
	$found = "true"
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0"	-ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Access" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Access\Security" -ea SilentlyContinue | Out-Null	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Excel" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Excel\Security" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Outlook" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Outlook\Security" -ea SilentlyContinue | Out-Null	 	 	 	 	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\PowerPoint" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\PowerPoint\Security" -ea SilentlyContinue | Out-Null	 	 	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\MS Project" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\MS Project\Security" -ea SilentlyContinue | Out-Null	 	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Publisher" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Publisher\Security" -ea SilentlyContinue | Out-Null	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Word" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Word\Security" -ea SilentlyContinue | Out-Null	 	 	 

	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Access\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Excel\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Outlook\Security" -Name "level" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null	 	 
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\PowerPoint\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\MS Project\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null	 	 
     Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Publisher\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null	 
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\Word\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null
	 Write-Host "** Office 2013 macros disabled. **" -foreground magenta
    }

# Office 2016
if (Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0")
    {
	$found = "true"
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0"	-ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Access" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Access\Security" -ea SilentlyContinue | Out-Null	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Excel" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Excel\Security" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Outlook" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Outlook\Security" -ea SilentlyContinue | Out-Null	 	 	 	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint\Security" -ea SilentlyContinue | Out-Null	 	 	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\MS Project" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\MS Project\Security" -ea SilentlyContinue | Out-Null	 	 	 	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Publisher" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Publisher\Security" -ea SilentlyContinue | Out-Null	 
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Word" -ea SilentlyContinue | Out-Null
	 New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Word\Security" -ea SilentlyContinue | Out-Null	 	 	 

	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Access\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Excel\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Outlook\Security" -Name "level" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null	 
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\MS Project\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null	 
     Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Publisher\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null	 
	 Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Word\Security" -Name "VBAWarnings" -Value 4 -Type DWord -Force -ea SilentlyContinue | Out-Null
	 Write-Host "** Office 2016 macros disabled. **" -foreground magenta
    }

if ($found){
	} else {
	  Write-Host "Office not found. Aborting..." -foreground yellow
	  throw
	}
