# choco-cleaner.ps1 v0.0.1 by Bill Curran 11/06/2017
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue if you have a suggestion/request.
Write-Host "choco-cleaner.ps1 v0.0.3 - deletes unnecessary residual Chocolatey files to free up disk space" -foreground white
Write-Host "Copyleft 2017-2018 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -foreground white

# Import preferences - see choco-cleaner.xml
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
$Optimizenupkgs = $ConfigFile.Settings.Preferences.Optimizenupkgs
$DeleteCache = $ConfigFile.Settings.Preferences.DeleteCache
$DeleteLicenseFiles = $ConfigFile.Settings.Preferences.DeleteLicenseFiles

# Import chocolatey.config
[xml]$ChocoConfigFile = Get-Content "$env:ChocolateyInstall\config\chocolatey.config"

#parse <add key="cacheLocation" value="" description="Cache location if not TEMP folder. Replaces `$env:TEMP` value." />
#$cacheLocation = $ConfigFile.config.cacheLocation.value

Write-Host "choco-cleaner Summary:" -foreground magenta
Write-Host " * Deleting unnecessary _processed.txt (WTF?) file..." -foreground magenta
Remove-Item -path $env:chocolateyinstall\bin\_processed.txt -ErrorAction SilentlyContinue

if ($DeleteLogs)
    {
     Write-Host " * Deleting unnecessary log files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\logs\* -recurse -exclude chocolatey.log,choco.summary.log -ErrorAction SilentlyContinue
    }

	if ($DeleteArchives)
    {	
     Write-Host " * Deleting unnecessary archive files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\* -recurse -include *.zip,*.rar,*.7z,*.gz,*.tar,*.sfx,*.iso -ErrorAction SilentlyContinue
	}

	if ($DeleteFileLogs)
    {	
     Write-Host " * Deleting unnecessary extracted file logs..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\* -recurse -include *.zip.txt,*.exe.txt,*.rar.txt,*.7z.txt,*.gz.txt,*.tar.txt,*.sfx.txt,*.iso.txt -ErrorAction SilentlyContinue
	}

	if ($DeleteMSInstallers)
    {	
     Write-Host " * Deleting unnecessary Microsoft installers..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\* -recurse -include *.msi,*.msu,*.msp -ErrorAction SilentlyContinue
	}

	if ($DeleteIgnoreFiles)
    {
     Write-Host " * Deleting unnecessary .ignore files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\* -recurse -include *.ignore -ErrorAction SilentlyContinue
	}

	if ($DeleteReadmes)
    {
     Write-Host " * Deleting unnecessary various read me files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\* -recurse -include credits.txt,readme.txt,*.md -ErrorAction SilentlyContinue
	}

	if ($DeleteOldChoco)
    {	
     Write-Host " * Deleting unnecessary old Chocolatey files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\* -recurse -include *.old -ErrorAction SilentlyContinue
	}

	if ($DeleteConfigBackupFile)
    {	
     Write-Host " * Deleting unnecessary config backup files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\chocolatey\config\chocolatey.config.backup -ErrorAction SilentlyContinue
	}

	if ($DeleteLibBad)
    {
     Write-Host " * Deleting unnecessary lib-bad files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\lib-bad -recurse -ErrorAction SilentlyContinue
	}

	if ($DeleteLibBkp)
    {	
     Write-Host " * Deleting unnecessary lib-bkp files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\lib-bkp -recurse -ErrorAction SilentlyContinue
	}

	if ($DeleteLicenseFiles)
    {
     Write-Host " * Deleting unnecessary license files..." -foreground magenta
     Remove-Item -path $env:chocolateyinstall\* -recurse -include license.txt,*.license.txt,verification.txt -exclude shimgen.license.txt -ErrorAction SilentlyContinue
	}
	
	if ($Optimizenupkgs)
    {	
     Write-Host " * Deleting unnecessary archives and executibles in .nupkg files..." -foreground magenta
     dir $env:chocolateyinstall\lib -recurse -include *.nupkg | %{7z d -r -tZIP $_.FullName *.exe *.zip *.rar *.7z *.gz *.tar *.sfx *.iso *.msi *.msu *.msp} | Out-Null
	}
# If cacheLocation in chocolatey.config has NOT been changed (most people)...
# I'm going to change this to read in the location
if ($DeleteCache)
    {
     Write-Host " * Deleting unnecessary cache files..." -foreground magenta
     Remove-Item -path $env:tmp\chocolatey -recurse -ErrorAction SilentlyContinue
	}

Write-Host choco-cleaner finished deleting unnecessary Chocolatey files! -foreground magenta
Write-Host "Found choco-cleaner.ps1 useful? Consider buying me a beer via PayPal at https://www.paypal.me/bcurran3donations" -ForegroundColor white
Start-Sleep -s 10