# choco-package-list-backup.ps1 (to local and cloud) by Bill Curran
# I couldn't have done this without the list parsing from Ammaar Limbada found at https://gist.github.com/alimbada/449ddf65b4ef9752eff3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# ROADMAP:
# Add ability to use a different source other than the Chocolatey public repository
# Add other cloud services support by request
# Open to suggestions - open a GitHub issue please if you have a suggestion/request.
# CAN NOT save/get installed package parameters as they are encrypted :(

$CPLBver        = "2018.02.24" # Version of this script
$ConfigFile     = "packages.config"
$SaveFolderName = "ChocolateyPackageListBackup" # Change the subfolder name if you don't like my default
$SaveVersions   = "False" # Specify if you want to save specific version info or not
$InstChoco      = "$Env:ChocolateyInstall\lib\instchoco\tools\InstChoco.exe" # location of InstChoco.exe if it exists
$CustomPath     = "c:\install"  # Edit to save to a special location of your choice

# Toggle True/False if you want to backup/not backup to the locations below
$UseCustomPath  = "False" # Change to True if you are using $CustomPath
$UseDocuments   = "True"
$UseHomeShare   = "True"  # Domain joined computers HOMEDRIVE support
$UseBox         = "True"
$UseDropbox     = "True"
$UseGoogleDrive = "True"
$UseNextcloud	= "True"
$UseOneDrive    = "True"
$UseReadyCLOUD  = "True"
$UseResilioSync = "True"
$UseSeafile     = "True"
$UseTonidoSync  = "True"


# Check the path to save packages.config and create if it doesn't exist
Function Check-SaveLocation{
    $CheckPath = Test-Path $SavePath
  If ($CheckPath -match "False")
     {
      New-Item $SavePath -Type Directory -force | out-null
     }   
    }

# Copy InstChoco.exe if it exists to the same location as packages.config for super duper easy re-installation
Function Check-InstChoco{
    $CheckICSource = Test-Path $InstChoco
	If ($CheckICSource -match "True"){
	   $CheckICDest = Test-Path $SavePath\InstChoco.exe
	   If ($CheckICDest -match "False")
	      {
	       Copy-Item $InstChoco $SavePath -force | out-null
	      }
	   }
    }
	
# Write out the saved list of packages to packages.config
Function Write-PackageConfig{ 
    Check-SaveLocation
	Check-InstChoco
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
Write-Host "Copyleft 2018 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use" -ForegroundColor white

# Backup Chocolatey package names to packages.config file in custom defined path you set in $CustomPath above in line 16
if ($UseCustomPath -match "True" -and (Test-Path $CustomPath))
   {
    $SavePath   = "$CustomPath\$SaveFolderName"
    Write-PackageConfig
   }
	
# Backup Chocolatey package names on local computer to packages.config file in the Documents folder
if ($UseDocuments -match "True" -and (Test-Path $Env:USERPROFILE\Documents))
   {
    $SavePath   = "$Env:USERPROFILE\Documents\$SaveFolderName"
    Write-PackageConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Box (Sync) directory if it exists
if ($UseBox -match "True" -and (Test-Path "$Env:USERPROFILE\Box Sync"))
   {
    $SavePath = "$Env:USERPROFILE\Box Sync\$SaveFolderName\$Env:ComputerName"
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

# Backup Chocolatey package names on local computer to packages.config file in Nextcloud directory if it exists
if ($UseNextcloud -match "True" -and (Test-Path $Env:USERPROFILE\Nextcloud))
   {
    $SavePath = "$Env:USERPROFILE\Nextcloud\$SaveFolderName\$Env:ComputerName"
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
if ($UseResilioSync -match "True" -and (Test-Path "$Env:USERPROFILE\Resilio Sync"))
   {
    $SavePath = "$Env:USERPROFILE\Resilio Sync\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }   

# Backup Chocolatey package names on local computer to packages.config file in Seafile directory if it exists
if ($UseSeafile -match "True" -and (Test-Path $Env:USERPROFILE\Documents\Seafile))
   {
    $SavePath = "$Env:USERPROFILE\Seafile\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in TonidoSync directory if it exists
if ($UseTonidoSync -match "True" -and (Test-Path $Env:USERPROFILE\Documents\TonidoSync))
   {
    $SavePath = "$Env:USERPROFILE\Documents\TonidoSync\$SaveFolderName\$Env:ComputerName"
    Write-PackageConfig
   }

     
   
Write-Host "TO RE-INSTALL YOUR CHOCOLATEY PACKAGES:" -ForegroundColor magenta 
Write-Host "1> Go to the location of your saved PACKAGES.CONFIG file and type CINST PACKAGES.CONFIG -Y" -ForegroundColor magenta 
Write-Host "2> Get InstChoco and let it do it for you! - https://chocolatey.org/packages/InstChoco" -ForegroundColor magenta 
Write-Host "Found choco-package-list-backup.ps1 useful? Consider buying me a beer via PayPal at https://www.paypal.me/bcurran3donations" -ForegroundColor white


