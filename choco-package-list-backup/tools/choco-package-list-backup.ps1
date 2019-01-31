# choco-package-list-backup.ps1 (to local and cloud) by Bill Curran
# I couldn't have done this without the list parsing from Ammaar Limbada found at https://gist.github.com/alimbada/449ddf65b4ef9752eff3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# ROADMAP:
# Add other cloud services support by request
# Save --packageparameters
# Open to suggestions - open a GitHub issue please if you have a suggestion/request.

Write-Host "choco-package-list-backup.ps1 v2019.01.29 - backup Chocolatey package list locally and to the cloud" -Foreground White
Write-Host "Copyleft 2017-2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -Foreground White
Write-Host
Write-Host "Choco Package List Backup Summary:" -Foreground Magenta

$Date = Get-Date -UFormat %Y-%m-%d
$ICinstalled = Test-Path "$ENV:ChocolateyInstall\lib\instchoco\tools\InstChoco.exe"
$PinnedPackages=choco pin list -r
$PinnedPackagesFile = "pins.bat"
$PPCinstalled = Test-Path $ENV:ChocolateyInstall\config\persistentpackages.config

# Import preferences - see choco-package-list-backup.xml in Chocolatey's bin dir
[xml]$ConfigFile = Get-Content "$ENV:ChocolateyInstall\bin\choco-package-list-backup.xml"
$PackagesListFile = $ConfigFile.Settings.Preferences.PackagesListFile
$SaveFolderName = $ConfigFile.Settings.Preferences.SaveFolderName
$SaveVersions = $ConfigFile.Settings.Preferences.SaveVersions
$AppendDate = $ConfigFile.Settings.Preferences.AppendDate
$CustomPath = $ConfigFile.Settings.Preferences.CustomPath
$SaveAllProgramsList = $ConfigFile.Settings.Preferences.SaveAllProgramsList
$AllProgramsListFile = $ConfigFile.Settings.Preferences.AllProgramsListFile

$UseCustomPath = $ConfigFile.Settings.Preferences.UseCustomPath 
$UseDocuments = $ConfigFile.Settings.Preferences.UseDocuments
$UseHomeShare = $ConfigFile.Settings.Preferences.UseHomeShare 
$UseBox = $ConfigFile.Settings.Preferences.UseBox
$UseDropbox = $ConfigFile.Settings.Preferences.UseDropbox
$UseGoogleDrive = $ConfigFile.Settings.Preferences.UseGoogleDrive
$UseiCloudDrive = $ConfigFile.Settings.Preferences.UseiCloudDrive
$UseNextcloud = $ConfigFile.Settings.Preferences.UseNextcloud
$UseOneDrive = $ConfigFile.Settings.Preferences.UseOneDrive
$UseownCloud = $ConfigFile.Settings.Preferences.UseownCloud
$UseReadyCLOUD = $ConfigFile.Settings.Preferences.UseReadyCLOUD
$UseResilioSync = $ConfigFile.Settings.Preferences.UseResilioSync
$UseSeafile = $ConfigFile.Settings.Preferences.UseSeafile
$UseTonidoSync = $ConfigFile.Settings.Preferences.UseTonidoSync

if ($AppendDate -eq "true"){
    if ($PackagesListFile -eq "packages.config"){
		 $PackagesListArchival = "packages_$Date.config"
		} else {
		  $PackagesListArchival = $PackagesListFile+"_$Date.config"
		}
 }

# Check the path to save packages.config and create if it doesn't exist
Function Check-SaveLocation{
    $CheckPath = Test-Path $SavePath
  If ($CheckPath -match "False")
     {
      New-Item $SavePath -Type Directory -force | out-null
     }   
    }

# Copy persistentpackages.config if it exists to the same location as packages.config
Function Copy-PPConfig{
   Copy-Item $ENV:ChocolateyInstall\config\persistentpackages.config $SavePath -force | out-null
   Write-Host "  ** $SavePath\persistentpackages.config SAVED!" -Foreground Green 
  }
	
# Copy InstChoco.exe if it exists to the same location as packages.config for super duper easy re-installation
Function Copy-InstChoco{
    $InstChoco = "$ENV:ChocolateyInstall\lib\instchoco\tools\InstChoco.exe" # location of InstChoco.exe if it exists
    $CheckICDest = Test-Path $SavePath\InstChoco.exe
    If ($CheckICDest -match "False")
       {
        Copy-Item $InstChoco $SavePath -force | out-null
        Write-Host "  ** $SavePath\InstChoco.exe SAVED!" -Foreground Green 
	   } else {
	     $ICSource = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($InstChoco).FileVersion
	     $ICDest = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("$SavePath\InstChoco.exe").FileVersion
	     if ($ICSource -ne $ICDest)
	        {
	         Copy-Item $InstChoco $SavePath -force | out-null
	         Write-Host "  ** $SavePath\InstChoco.exe COPIED!" -Foreground Green
	        }
	   }
  }

# Write out the saved list of ALL installed programs to AllProgramsList.txt
Function Write-AllProgramsList{
    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table >"$SavePath\$AllProgramsListFile"
    Write-Host "  ** $SavePath\$AllProgramsListFile SAVED!" -Foreground Green

# 2nd copy in format AllProgramsList_date.txt if AppendDate is set to true	
    if ($AppendDate -eq "true"){
	    $AllProgramsListFileArchival = $AllProgramsListFile.Replace(".txt","")+"_$Date.txt"
        Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher | Format-Table >$SavePath\$AllProgramsListFileArchival
        Write-Host "  ** $SavePath\$AllProgramsListFileArchival SAVED!" -Foreground Green
       }
}  

# Write out pins.bat to easily re-pin previously pinned packages
Function Write-PinnedList{
    Write-Output "@echo off`nrem pinned packages found by choco-package-list-backup.ps1 on $Date :`necho   ** Re-pinning previously pinned Chocolatey packages." | Set-Content -Path "$SavePath\$PinnedPackagesFile"
	if ($SaveVersions -match "True")
	   {
        choco pin list -r | % {"choco pin add -n=$($_.SubString(0, $_.IndexOf("|"))) --version $($_.SubString($_.IndexOf("|") + 1))"} | Add-Content "$SavePath\$PinnedPackagesFile"
	   } else {
         choco pin list -r | % {"choco pin add -n=$($_.SubString(0, $_.IndexOf("|")))"} | Add-Content "$SavePath\$PinnedPackagesFile"
		}
	Write-Host "  ** $SavePath\$PinnedPackagesFile SAVED!" -Foreground Green
	}
  
# Write out the saved list of packages to packages.config
Function Write-PackagesConfig{
    Check-SaveLocation
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>`n<packages>" | Set-Content -Path "$SavePath\$PackagesListFile"
	if ($SaveVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" } | Add-Content "$SavePath\$PackagesListFile"
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" } | Add-Content "$SavePath\$PackagesListFile"
		}
    "</packages>" | Add-Content "$SavePath\$PackagesListFile"
	Write-Host "  ** $SavePath\$PackagesListFile SAVED!" -Foreground Green

# 2nd copy in format packages.config_date.config if AppendDate is set to true	
	if ($AppendDate -eq "true"){
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>`n<packages>" | Set-Content -Path "$SavePath\$PackagesListArchival"
	    if ($SaveVersions -match "True")
	       {
            choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" } | Add-Content "$SavePath\$PackagesListArchival"
	       } else {
             choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" } | Add-Content "$SavePath\$PackagesListArchival"
		    }
    "</packages>" | Add-Content "$SavePath\$PackagesListArchival"
	    Write-Host "  ** $SavePath\$PackagesListArchival SAVED!" -Foreground Green 
    }
	
	if ($PPCinstalled) {Copy-PPConfig}
	if ($SaveAllProgramsList -eq "true"){Write-AllProgramsList}
	if (!$PinnedPackages){Remove-Item "$SavePath\$PinnedPackagesFile" -ea SilentlyContinue | Out-Null }
	if ($PinnedPackages){Write-PinnedList}
	if ($ICinstalled) {Copy-InstChoco}
	Write-Host
}

# Backup Chocolatey package names to packages.config file in custom defined path you set as CustomPath in XLM config file
if ($UseCustomPath -match "True" -and (Test-Path $CustomPath))
   {
    $SavePath   = "$CustomPath\$SaveFolderName"
    Write-PackagesConfig
   }
	
# Backup Chocolatey package names on local computer to packages.config file in the Documents folder
$DocumentsFolder = [Environment]::GetFolderPath("MyDocuments")
if ($DocumentsFolder -ne ""){
   if ($UseDocuments -match "True" -and (Test-Path $DocumentsFolder))
       {
        $SavePath   = "$DocumentsFolder\$SaveFolderName"
        Write-PackagesConfig
       }
   } 
   
# Backup Chocolatey package names on local computer to packages.config file in Box (Sync) directory if it exists
if ($UseBox -match "True" -and (Test-Path "$ENV:USERPROFILE\Box Sync"))
   {
    $SavePath = "$ENV:USERPROFILE\Box Sync\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }    
   
# Check for Dropbox personal and business paths (Thanks ebbek!)
if (Test-Path $ENV:AppData\Dropbox\info.json)
{
    $DropboxPersonal = ((Get-Content $ENV:AppData\Dropbox\info.json) -join '`n' | ConvertFrom-json).personal.path
    $DropboxBusiness = ((Get-Content $ENV:AppData\Dropbox\info.json) -join '`n' | ConvertFrom-json).business.path
}
elseif (Test-Path $ENV:LocalAppData\Dropbox\info.json)
{
    $DropboxPersonal = ((Get-Content $ENV:LocalAppData\Dropbox\info.json) -join '`n' | ConvertFrom-json).personal.path
    $DropboxBusiness = ((Get-Content $ENV:LocalAppData\Dropbox\info.json) -join '`n' | ConvertFrom-json).business.path
}

# Backup Chocolatey package names on local computer to packages.config file in Personal Dropbox directory if it exists
if ($UseDropbox -match "True" -and ($DropboxPersonal) -and (Test-Path $DropboxPersonal))
   {
    $SavePath = "$DropboxPersonal\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Business Dropbox directory if it exists
if ($UseDropbox -match "True" -and ($DropboxBusiness) -and (Test-Path $DropboxBusiness))
   {
    $SavePath = "$DropboxBusiness\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Google Drive/Backup and Sync directory if it exists
if ($UseGoogleDrive -match "True" -and (Test-Path "$ENV:USERPROFILE\Google Drive"))   
   {
    $SavePath = "$ENV:USERPROFILE\Google Drive\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Google Drive FS "My Drive" directory if it exists (Thanks ebbek!)
$GFSInstalled=(Test-Path -path HKCU:Software\Google\DriveFS\Share)
if ($GFSInstalled)
   {
    $GoogleFSmountpoint = (Get-ItemProperty -path Registry::HKEY_CURRENT_USER\Software\Google\DriveFS\Share).MountPoint
    if ($UseGoogleDrive -match "True" -and ($GoogleFSmountpoint) -and (Test-Path "${GoogleFSmountpoint}:\My Drive"))
       {
        $SavePath = "${GoogleFSmountpoint}:\My Drive\$SaveFolderName\$ENV:ComputerName"
        Write-PackagesConfig
       }
	}
   
# Backup Chocolatey package names on local computer to packages.config file on your HOMESHARE directory if it exists
if ($ENV:HOMESHARE) {$ExistHomeShare="True"} else {$ExistHomeShare="False"}
if ($UseHomeShare -match "True" -and $ExistHomeShare -match "True")   
   {
    $SavePath = "$ENV:HOMESHARE\$SaveFolderName\$ENV:ComputerName"   
    Write-PackagesConfig
   }      

# Backup Chocolatey package names on local computer to packages.config file in iCloudDrive directory if it exists
if ($UseiCloudDrive -match "True" -and (Test-Path $ENV:USERPROFILE\iCloudDrive))
   {
    $SavePath = "$ENV:USERPROFILE\iCloudDrive\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }    
   
# Backup Chocolatey package names on local computer to packages.config file in Nextcloud directory if it exists
if ($UseNextcloud -match "True" -and (Test-Path $ENV:USERPROFILE\Nextcloud))
   {
    $SavePath = "$ENV:USERPROFILE\Nextcloud\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   } 
   
# Backup Chocolatey package names on local computer to packages.config file in OneDrive directory if it exists
if ($ENV:OneDrive) {$OneDriveExists="True"} else {$OneDriveExists="False"}
if ($UseOneDrive -match "True" -and ($OneDriveExists -match "True"))
   {
    $SavePath = "$ENV:OneDrive\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }      

# Backup Chocolatey package names on local computer to packages.config file in ownCloud directory if it exists
if ($UseownCloud -match "True" -and (Test-Path "$ENV:USERPROFILE\ownCloud"))
   {
    $SavePath = "$ENV:USERPROFILE\ownCloud\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Netgear ReadyCLOUD directory if it exists
if ($UseReadyCLOUD -match "True" -and (Test-Path $ENV:USERPROFILE\ReadyCLOUD))
   {
    $SavePath = "$ENV:USERPROFILE\ReadyCLOUD\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }

# Backup Chocolatey package names on local computer to packages.config file in Public directory if running under system account (only place it will save running under system except $CustomPath
if ($ENV:computername -eq $ENV:username.trim('$'))
   {
    $SavePath = "$ENV:PUBLIC\$SaveFolderName"
    Write-PackagesConfig
   }

# Backup Chocolatey package names on local computer to packages.config file in Resilio Sync directory if it exists
if ($UseResilioSync -match "True" -and (Test-Path "$ENV:USERPROFILE\Resilio Sync"))
   {
    $SavePath = "$ENV:USERPROFILE\Resilio Sync\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }   

# Backup Chocolatey package names on local computer to packages.config file in Seafile directory if it exists
if ($UseSeafile -match "True" -and (Test-Path $ENV:USERPROFILE\Documents\Seafile))
   {
    $SavePath = "$ENV:USERPROFILE\Seafile\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in TonidoSync directory if it exists
if ($UseTonidoSync -match "True" -and (Test-Path $ENV:USERPROFILE\Documents\TonidoSync))
   {
    $SavePath = "$ENV:USERPROFILE\Documents\TonidoSync\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }

If ($ICinstalled){
     Write-Host "To re-install your Chocolatey packages: run INSTCHOCO -Y`n" -Foreground Magenta
   } else {
     Write-Host "To re-install your Chocolatey packages: run CINST PACKAGES.CONFIG -Y" -Foreground Magenta
     Write-Host "Consider getting InstChoco - The ULTIMATE Chocolatey and Chocolatey packages (re)installer!`nhttps://chocolatey.org/packages/InstChoco`n" -Foreground Cyan
   }
Write-Host "Found choco-package-list-backup.ps1 useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White
Start-Sleep -s 10 # Gives time to view before closing when run from Windows Start Menu shortcut
