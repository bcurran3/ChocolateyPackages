# Choco-Cleaner.ps1 Copyleft 2017-2019 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

Write-Host "Choco-Cleaner.ps1 v0.0.5.2 (01/09/2019) - deletes unnecessary residual Chocolatey files to free up disk space" -ForeGround White
Write-Host "Copyleft 2017-2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -ForeGround White

#$BinaryExtensions=@("*.exe","*.msi","*.zip","*.rar","*.7z","*.gz","*.tar","*.sfx","*.iso","*.img","*.msu","*.msp") # miss any?

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
     $FreeBefore = Get-PSDrive C | foreach-object {$_.Free}
    }
Write-Host "Choco-Cleaner Summary:" -ForeGround Magenta
Write-Host "  **  Deleting unnecessary Chocolatey _processed.txt (WTF?) file..." -ForeGround Green
Remove-Item -path $env:ChocolateyInstall\bin\_processed.txt -ErrorAction SilentlyContinue

if ($DeleteIgnoreFiles)
    {
     Write-Host "  **  Deleting unnecessary Chocolatey .ignore files..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.ignore -ErrorAction SilentlyContinue
	}

if ($DeleteOldChoco)
    {	
     Write-Host "  **  Deleting unnecessary Chocolatey .old files..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.old -ErrorAction SilentlyContinue
	}

if ($DeleteCache)
    {
     Write-Host "  **  Deleting unnecessary Chocolatey cache files..." -ForeGround Green
     Remove-Item -path $env:tmp\chocolatey -recurse -ErrorAction SilentlyContinue
	 Remove-Item -path $env:SystemRoot\temp\chocolatey -recurse -ErrorAction SilentlyContinue
	 if ($cacheLocation) {
	   Remove-Item -path $cacheLocation -recurse -ErrorAction SilentlyContinue
	   }
	}	
	
if ($DeleteConfigBackupFile)
    {	
     Write-Host "  **  Deleting unnecessary Chocolatey config backup files..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\config\chocolatey.config.backup -ErrorAction SilentlyContinue
	}	

if ($DeleteLibBad)
    {
     Write-Host "  **  Deleting unnecessary Chocolatey lib-bad package files..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\lib-bad -recurse -ErrorAction SilentlyContinue
	}

if ($DeleteLibBkp)
    {	
     Write-Host "  **  Deleting unnecessary Chocolatey lib-bkp package files..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\lib-bkp -recurse -ErrorAction SilentlyContinue
	}	

if ($DeleteFileLogs)
    {	
     Write-Host "  **  Deleting unnecessary Chocolatey extracted file logs..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.zip.txt,*.exe.txt,*.rar.txt,*.7z.txt,*.gz.txt,*.tar.txt,*.sfx.txt,*.iso.txt -ErrorAction SilentlyContinue
	}		
	
if ($DeleteLogs)
    {
     Write-Host "  **  Deleting unnecessary Chocolatey log files..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\logs\* -recurse -exclude chocolatey.log,choco.summary.log -ErrorAction SilentlyContinue
    }	
	
if ($DeleteArchives)
    {	
     Write-Host "  **  Deleting unnecessary Chocolatey package embedded archive files in toolsDir..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.zip,*.rar,*.7z,*.gz,*.tar,*.sfx,*.iso,*.img,*.msi,*.msu,*.msp -ErrorAction SilentlyContinue
	}

if ($Optimizenupkg)
    {	
     Write-Host "  **  Deleting unnecessary Chocolatey package embedded archives and executables in .nupkg files..." -ForeGround Green
     dir $env:ChocolateyInstall\lib -recurse -include *.nupkg | ForEach-Object {& $env:ChocolateyInstall\tools\7z.exe d -r -tZIP $_.FullName *.exe *.zip *.rar *.7z *.gz *.tar *.sfx *.iso *.msi *.msu *.msp} | Out-Null
	}
	
if ($DeleteLicenseFiles)
    {
     Write-Host "  **  Deleting unnecessary Chocolatey package embedded license files..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include license.txt,*.license.txt,verification.txt -exclude shimgen.license.txt -ErrorAction SilentlyContinue
	}	
	
if ($DeleteMSInstallers)
    {	
     Write-Host "  **  Deleting unnecessary Chocolatey package embedded Microsoft installers..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include *.msi -ErrorAction SilentlyContinue
	}
	
if ($DeleteReadmes)
    {
     Write-Host "  **  Deleting unnecessary Chocolatey package embedded various read me files..." -ForeGround Green
     Remove-Item -path $env:ChocolateyInstall\* -recurse -include credits.txt,readme.txt,*.md -ErrorAction SilentlyContinue
	}	

if ($DeleteNuGetCache)
    {
     Write-Host "  **  Deleting unnecessary Nuget cache files..." -ForeGround Green
     Remove-Item -path $env:USERPROFILE\AppData\Local\NuGet\Cache -recurse -ErrorAction SilentlyContinue
	}	
	
if ($env:ChocolateyInstall -match $env:SystemDrive -and $env:SystemDrive -eq "C:")
    {
     $FreeAfter  = Get-PSDrive C | foreach-object {$_.Free}
	 $FreedSpace = $FreeAfter - $FreeBefore
     $FreedSpace = $FreedSpace / 1024
	 Write-Host Choco-Cleaner finished deleting unnecessary Chocolatey files and saved you $freedspace.ToString('N0') KB! -ForeGround Magenta
    } else {
	  Write-Host choco-cleaner finished deleting unnecessary Chocolatey files! -ForeGround Magenta
	 }
Write-Host "Found Choco-Cleaner.ps1 useful?" -ForeGroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForeGroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForeGroundColor White
Start-Sleep -s 10

# TDL
# Recursively delete Chocolatey and NuGet cache files from all user directories
# Clean C:\ProgramData\chocolatey\lib-synced
# Clean C:\ProgramData\chocolatey\.chocolatey