# Choco-Cleaner.ps1 Copyleft 2017-2018 by Bill Curran 
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.
$CCver = "v0.0.5 (08/22/2018)"

Write-Host "Choco-Cleaner.ps1 $CCver - deletes unnecessary residual Chocolatey files to free up disk space" -foreground white
Write-Host "Copyleft 2017-2018 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -foreground white

# Import preferences from choco-cleaner.xml
[xml]$ConfigFile = Get-Content "$env:ChocolateyInstall\bin\choco-cleaner.xml"
$DeleteLogs = $ConfigFile.Settings.Preferences.DeleteLogs
$DeleteArchives = $ConfigFile.Settings.Preferences.DeleteArchives
$DeleteFileLogs = $ConfigFile.Settings.Preferences.DeleteFileLogs
$DeleteMSInstallers = $ConfigFile.Settings.Preferences.DeleteMSInstallers
$DeleteIgnoreFiles = $ConfigFile.Settings.Preferences.DeleteIgnoreFiles 
$DeleteReadmes = $ConfigFile.Settings.Preferences.DeleteReadmes
$DeleteOldChoco = $ConfigFile.Settings.Preferences.DeleteOldChoco 
$DeleteConfigBackupFile = $ConfigFile.Settings.Preferences.DeleteConfigBackupFile
$DeleteLibBad = $ConfigFile.Settings.Preferences.DeleteLibBad
$DeleteLibBkp = $ConfigFile.Settings.Preferences.DeleteLibBkp
$Optimizenupkg = $ConfigFile.Settings.Preferences.Optimizenupkg
$DeleteCache = $ConfigFile.Settings.Preferences.DeleteCache
$DeleteLicenseFiles = $ConfigFile.Settings.Preferences.DeleteLicenseFiles
# new configuration items since implementation of XML config in v0.0.3
$DeleteNuGetCache = $ConfigFile.Settings.Preferences.DeleteNuGetCache

# Import chocolatey.config and get cacheLocation if set
[xml]$ChocoConfigFile = Get-Content "$env:ChocolateyInstall\config\chocolatey.config"
$cacheLocation = $ChocoConfigFile.chocolatey.config | % { $_.add } | ? { $_.key -eq 'cacheLocation' } | select -Expand value

if ($env:ChocolateyInstall -match $env:SystemDrive -and $env:SystemDrive -eq "C:")
    {
     $FreeBefore = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Foreach-Object {$_.FreeSpace}
    }
Write-Host "Choco-Cleaner Summary:" -foreground magenta
Write-Host " * Deleting unnecessary Chocolatey _processed.txt (WTF?) file..." -foreground green
Remove-Item -path $env:ChocolateyInstall\bin\_processed.txt -ErrorAction SilentlyContinue

if ($DeleteIgnoreFiles)
    {
     Write-Host " * Deleting unnecessary Chocolatey .ignore files..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.ignore -ErrorAction SilentlyContinue
	}

if ($DeleteOldChoco)
    {	
     Write-Host " * Deleting unnecessary Chocolatey .old files..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.old -ErrorAction SilentlyContinue
	}

if ($DeleteCache)
    {
     Write-Host " * Deleting unnecessary Chocolatey cache files..." -foreground green
     Remove-Item -path $env:tmp\chocolatey -recurse -ErrorAction SilentlyContinue
	 Remove-Item -path $env:SystemRoot\temp\chocolatey -recurse -ErrorAction SilentlyContinue
	 if ($cacheLocation) {
	   Remove-Item -path $cacheLocation -recurse -ErrorAction SilentlyContinue
	   }
	}	
	
if ($DeleteConfigBackupFile)
    {	
     Write-Host " * Deleting unnecessary Chocolatey config backup files..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\config\chocolatey.config.backup -ErrorAction SilentlyContinue
	}	

if ($DeleteLibBad)
    {
     Write-Host " * Deleting unnecessary Chocolatey lib-bad package files..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\lib-bad -recurse -ErrorAction SilentlyContinue
	}

if ($DeleteLibBkp)
    {	
     Write-Host " * Deleting unnecessary Chocolatey lib-bkp package files..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\lib-bkp -recurse -ErrorAction SilentlyContinue
	}	

if ($DeleteFileLogs)
    {	
     Write-Host " * Deleting unnecessary Chocolatey extracted file logs..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.zip.txt,*.exe.txt,*.rar.txt,*.7z.txt,*.gz.txt,*.tar.txt,*.sfx.txt,*.iso.txt -ErrorAction SilentlyContinue
	}		
	
if ($DeleteLogs)
    {
     Write-Host " * Deleting unnecessary Chocolatey log files..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\logs\* -recurse -exclude chocolatey.log,choco.summary.log -ErrorAction SilentlyContinue
    }	
	
if ($DeleteArchives)
    {	
     Write-Host " * Deleting unnecessary Chocolatey package embedded archive files in toolsDir..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.zip,*.rar,*.7z,*.gz,*.tar,*.sfx,*.iso -ErrorAction SilentlyContinue
	}

if ($Optimizenupkg)
    {	
     Write-Host " * Deleting unnecessary Chocolatey package embedded archives and executables in .nupkg files..." -foreground green
     dir $env:ChocolateyInstall\lib -recurse -include *.nupkg | ForEach-Object {& $env:ChocolateyInstall\tools\7z.exe d -r -tZIP $_.FullName *.exe *.zip *.rar *.7z *.gz *.tar *.sfx *.iso *.msi *.msu *.msp} | Out-Null
	}
	
if ($DeleteLicenseFiles)
    {
     Write-Host " * Deleting unnecessary Chocolatey package embedded license files..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include license.txt,*.license.txt,verification.txt -exclude shimgen.license.txt -ErrorAction SilentlyContinue
	}	
	
if ($DeleteMSInstallers)
    {	
     Write-Host " * Deleting unnecessary Chocolatey package embedded Microsoft installers..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.msi,*.msu,*.msp -ErrorAction SilentlyContinue
	}
	
if ($DeleteReadmes)
    {
     Write-Host " * Deleting unnecessary Chocolatey package embedded various read me files..." -foreground green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include credits.txt,readme.txt,*.md -ErrorAction SilentlyContinue
	}	

if ($DeleteNuGetCache)
    {
     Write-Host " * Deleting unnecessary Nuget cache files..." -foreground green
     Remove-Item -path $env:USERPROFILE\AppData\Local\NuGet\Cache -recurse -ErrorAction SilentlyContinue
	}	
	
if ($env:ChocolateyInstall -match $env:SystemDrive -and $env:SystemDrive -eq "C:")
    {
     $FreeAfter = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Foreach-Object {$_.FreeSpace}
	 $FreedSpace = $FreeAfter - $FreeBefore
     $FreedSpace = $FreedSpace / 1024
	 Write-Host Choco-Cleaner finished deleting unnecessary Chocolatey files and saved you $freedspace.ToString('N0') KB! -foreground magenta
    } else {
	  Write-Host choco-cleaner finished deleting unnecessary Chocolatey files! -foreground magenta
	 }
Write-Host "Found Choco-Cleaner.ps1 useful?" -ForegroundColor white
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor white
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor white
Start-Sleep -s 10