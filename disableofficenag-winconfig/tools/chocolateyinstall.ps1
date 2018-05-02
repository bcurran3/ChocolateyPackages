$packageName = 'disabledefender-winconfig'
$ErrorActionPreference = 'Stop'
# REFERENCE: https://support.office.com/en-us/article/Office-repeatedly-prompts-you-to-activate-on-a-new-PC-a9a6b05f-f6ce-4d1f-8d49-eb5007b64ba1

# Office 2013
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Office\15.0\Common\OEM")
    {
	 $found=1
     Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Office\15.0\Common\OEM" -Force
	} 

if (Test-Path -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Common\OEM")
    {
	 $found=1
     Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Common\OEM" -Force
    } 	
# Office 2016
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Office\16.0\Common\OEM")
    {
	 $found=1
	 Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Office\16.0\Common\OEM" -Force
    } 

if (Test-Path -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\OEM")
    {
	 $found=1
	 Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\OEM" -Force
    } 

if ($found){
	Write-Host Activation prompt removed. -foreground green
	} else {
	  Write-Host Activation prompt not found. Aborting... -foreground magenta
	  throw
	}
