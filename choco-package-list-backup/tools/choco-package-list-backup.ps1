# choco-package-list-backup.ps1 (to local and cloud) by Bill Curran
# I couldn't have done this without the list parsing from Ammaar Limbada found at https://gist.github.com/alimbada/449ddf65b4ef9752eff3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# ROADMAP:
# Put the checking of save locations in a loop
# Add other cloud services support by request
# Add ability to use a different source other than the Chocolatey public repository
# Possibly compile to a proper executable program - scratched, can't modify variables as easily!
# Open to suggestions - open a GitHub issue please if you have a suggestion/request.

$CPLBver        = "2017.08.16" # version of this script
$ConfigFile     = "packages.config"
$SaveFolderName = "ChocolateyPackageListBackup" # Change the subfolder name if you don't like my default
$SaveVersions   = "False" # Specify if you want to save specific version info or not
$InstallChoco   = "$Env:ChocolateyInstall\lib\installchoco\tools\InstallChoco.exe" # location of InstallChoco.exe if it exists

# Toggle True/False if you want to backup/not backup to the locations below
$UseDocuments   = "True"
$UseHomeShare   = "True"  # Domain joined computers HOMEDRIVE support
$UseDropbox     = "True"
$UseGoogleDrive = "True"
$UseOneDrive    = "True"
$UseReadyCLOUD  = "True"
$UseResilioSync = "True"
$UseTonidoSync  = "True"

# Check the path to save packages.config and create if it doesn't exist
Function Check-SaveLocation{
    $CheckPath = Test-Path $SavePath
  If ($CheckPath -match "False")
     {
      New-Item $SavePath -Type Directory -force | out-null
     }   
    }

# Copy InstallChoco.exe if it exists to the same location as packages.config for super duper easy re-installation
Function Check-InstallChoco{
    $CheckICSource = Test-Path $InstallChoco
	If ($CheckICSource -match "True"){
	   $CheckICDest = Test-Path $SavePath\InstallChoco.exe
	   If ($CheckICDest -match "False")
	      {
	       Copy-Item $InstallChoco $SavePath -force | out-null
	      }
	   }
    }
	
# Write out the saved list of packages to packages.config
Function Write-PackageConfig{ 
    Check-SaveLocation
	Check-InstallChoco
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>" >"$SavePath\$ConfigFile"
    Write-Output "<packages>" >>"$SavePath\$ConfigFile"
	if ($SaveVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }>>"$SavePath\$ConfigFile"
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" }>>"$SavePath\$ConfigFile"
		 }
    Write-Output "</packages>" >>"$SavePath\$ConfigFile"
	Write-Host "$SavePath\$ConfigFile SAVED!" -ForegroundColor green 
    }

Write-Host "choco-package-list-backup.ps1 v$CPLBver" - backup Chocolatey package list locally and to the cloud -ForegroundColor white
Write-Host "Copyleft 2017 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -ForegroundColor white
	
# Backup Chocolatey package names on local computer to packages.config file in the Documents folder
if ($UseDocuments -match "True" -and (Test-Path $Env:USERPROFILE\Documents))
   {
    $SavePath   = "$Env:USERPROFILE\Documents\$SaveFolderName"
    Write-PackageConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Dropbox directory if it exists
if ($UseDropbox -match "True" -and (Test-Path $Env:USERPROFILE\Dropbox))   
   {
    $SavePath = "$Env:USERPROFILE\Dropbox\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Google Drive directory if it exists
if ($UseGoogleDrive -match "True" -and (Test-Path "$Env:USERPROFILE\Google Drive"))   
   {
    $SavePath = "$Env:USERPROFILE\Google Drive\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }   
   
# Backup Chocolatey package names on local computer to packages.config file on your HOMESHARE directory if it exists
#if ($UseHomeShare -match "True" -and (Test-Path "$Env:HOMESHARE" -eq "True"))
$ExistHomeShare = (Test-Path "Env:HOMESHARE")
if ($UseHomeShare -match "True" -and $ExistHomeShare -match "True")   
   {
    $SavePath = "$Env:HOMESHARE\$SaveFolderName\$Env:ComputerName"   
    Write-PackageConfig
   }      
   
# Backup Chocolatey package names on local computer to packages.config file in OneDrive directory if it exists
if ($UseOneDrive -match "True" -and (Test-Path $Env:USERPROFILE\OneDrive))
   {
    $SavePath = "$Env:USERPROFILE\OneDrive\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }      
   
# Backup Chocolatey package names on local computer to packages.config file in Netgear ReadyCLOUD directory if it exists
if ($UseReadyCLOUD -match "True" -and (Test-Path $Env:USERPROFILE\ReadyCLOUD))
   {
    $SavePath = "$Env:USERPROFILE\ReadyCLOUD\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }

# Backup Chocolatey package names on local computer to packages.config file in Resilio Sync directory if it exists
if ($UseReadyCLOUD -match "True" -and (Test-Path "$Env:USERPROFILE\Resilio Sync"))
   {
    $SavePath = "$Env:USERPROFILE\Resilio Sync\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }   
   
# Backup Chocolatey package names on local computer to packages.config file in TonidoSync directory if it exists
if ($UseTonidoSync -match "True" -and (Test-Path $Env:USERPROFILE\Documents\TonidoSync))
   {
    $SavePath = "$Env:USERPROFILE\Documents\TonidoSync\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }

Write-Host "TO RE-INSTALL YOUR CHOCOLATEY PACKAGES:" -ForegroundColor magenta 
Write-Host "Go to the location of your saved packages.config file and type CINST PACKAGES.CONFIG -Y" -ForegroundColor magenta 
Write-Host "Found choco-package-list-backup.ps1 useful? Consider buying me a beer via PayPal at the e-mail address above." -ForegroundColor white






