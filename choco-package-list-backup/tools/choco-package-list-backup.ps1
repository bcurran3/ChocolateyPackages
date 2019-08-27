#$ErrorActionPreference = 'Stop'
# choco-package-list-backup.ps1 (to local and cloud) by Bill Curran
# I couldn't have done this without the list parsing from Ammaar Limbada found at https://gist.github.com/alimbada/449ddf65b4ef9752eff3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# ROADMAP:
# Add other cloud services support by request
# Save --packageparameters
# Open to suggestions - open a GitHub issue please if you have a suggestion/request.

Write-Host "choco-package-list-backup.ps1 v2019.08.27 - backup Chocolatey packages list locally and to the cloud" -Foreground White
Write-Host "Copyleft 2017-2019 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White
Write-Host "Choco Package List Backup Summary:" -Foreground Magenta

$Date          = Get-Date -UFormat %Y-%m-%d
$ErrorArray    = @("this is try","error converted","access to path") #errors caused by Chocolatey not being multi-instance aware (Hopefully in v1.0!)
$ICinstalled   = Test-Path "$ENV:ChocolateyInstall\lib\instchoco\tools\InstChoco.exe"
$PinnedPackages=choco pin list -r
$PinnedPackagesFile = 'pins.bat'
$PPCinstalled  = Test-Path "$ENV:ChocolateyInstall\config\persistentpackages.config"
$scriptDir     = "$ENV:ChocolateyToolsLocation\BCURRAN3"
$ScriptConfig  = 'choco-package-list-backup.config'

if ($args -eq "-EditConfig") {
    Write-Host "  ** Editing contents of $scriptDir\$ScriptConfig." -Foreground Magenta
    if (Test-Path $ENV:ChocolateyInstall\bin\notepad++.exe){$Editor="notepad++.exe"} else {$Editor="notepad.exe"}
	&$Editor "$scriptDir\$ScriptConfig"
	return
}

# Import preferences - see comments in choco-package-list-backup.config for settings 
[xml]$ConfigFile = Get-Content "$scriptDir\choco-package-list-backup.config"
$PackagesListFile = $ConfigFile.Settings.Preferences.PackagesListFile
$SaveFolderName = $ConfigFile.Settings.Preferences.SaveFolderName
$SaveTitleSummary = $ConfigFile.Settings.Preferences.SaveTitleSummary
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

if ($AppendDate -eq "True"){
    if ($PackagesListFile -eq "packages.config"){
		 $PackagesListArchival = "packages_$Date.config"
		} else {
		  $PackagesListArchival = $PackagesListFile+"_$Date.config"
		}
 }

# functions --------------------------------------------------------------------------------

# Check the path to save packages.config and create if it doesn't exist
Function Check-SaveLocation{
    $CheckPath = Test-Path $SavePath
  If ($CheckPath -match "False")
     {
      New-Item $SavePath -Type Directory -Force | Out-Null
     }   
    }

# Copy choco-package-list-backup.config to the same location as packages.config
Function Copy-Config{
   Copy-Item "$scriptDir\$ScriptConfig" $SavePath -Force | Out-Null
   Write-Host "  ** $SavePath\$ScriptConfig SAVED!" -Foreground Green 
  }

# Copy persistentpackages.config if it exists to the same location as packages.config
Function Copy-PPConfig{
   Copy-Item $ENV:ChocolateyInstall\config\persistentpackages.config $SavePath -Force | Out-Null
   Write-Host "  ** $SavePath\persistentpackages.config SAVED!" -Foreground Green 
  }
	
# Copy InstChoco.exe if it exists to the same location as packages.config for super duper easy re-installation
Function Copy-InstChoco{
    $InstChoco = "$ENV:ChocolateyInstall\lib\instchoco\tools\InstChoco.exe" # location of InstChoco.exe if it exists
    $CheckICDest = Test-Path $SavePath\InstChoco.exe
    If ($CheckICDest -match "False")
       {
        Copy-Item $InstChoco $SavePath -Force | Out-Null
        Write-Host "  ** $SavePath\InstChoco.exe SAVED!" -Foreground Green 
	   } else {
	     $ICSource = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($InstChoco).FileVersion
	     $ICDest = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("$SavePath\InstChoco.exe").FileVersion
	     if ($ICSource -ne $ICDest)
	        {
	         Copy-Item $InstChoco $SavePath -Force | Out-Null
	         Write-Host "  ** $SavePath\InstChoco.exe COPIED!" -Foreground Green
	        }
	   }
  }

# ENHANCEMENT: Below for future release adding extra description info to packages.config
# Import package.nuspec file to get extended package info
function Get-NuspecInfo($PackageName,$NuspecTagRequest){
   $nuspecXML = "$ENV:ChocolateyInstall\lib\$PackageName\$PackageName.nuspec"
   [xml]$nuspecFile = Get-Content $nuspecXML
#   $NuspecAuthors = $nuspecFile.package.metadata.authors
#   $NuspecBugTrackerURL = $nuspecFile.package.metadata.bugtrackerurl
#   $NuspecConflicts = $nuspecFile.package.metadata.conflicts # Built for the future
#   $NuspecCopyright = $nuspecFile.package.metadata.copyright
#   $NuspecDependencies = $nuspecFile.package.metadata.dependencies # Not fully implemented yet
#   $NuspecDescription = $nuspecFile.package.metadata.description
#   $NuspecDocsURL = $nuspecFile.package.metadata.docsurl
#   $NuspecFiles = $nuspecFile.package.files.file # Not fully implemented yet
#   $NuspecIconURL = $nuspecFile.package.metadata.iconurl
#   $NuspecID = $nuspecFile.package.metadata.id
#   $NuspecLicenseURL = $nuspecFile.package.metadata.licenseurl
#   $NuspecMailingListURL = $nuspecFile.package.metadata.mailinglisturl
#   $NuspecOwners = $nuspecFile.package.metadata.owners
#   $NuspecPackageSourceURL = $nuspecFile.package.metadata.packagesourceurl
#   $NuspecProjectSourceURL = $nuspecFile.package.metadata.projectsourceurl
#   $NuspecProjectURL = $nuspecFile.package.metadata.projecturl
#   $NuspecProvides = $nuspecFile.package.metadata.provides # Built for the future
#   $NuspecReleaseNotes = $nuspecFile.package.metadata.releasenotes
#   $NuspecReplaces = $nuspecFile.package.metadata.replaces # Built for the future
#   $NuspecRequireLicenseAcceptance = $nuspecFile.package.metadata.requirelicenseacceptance
   $NuspecSummary = $nuspecFile.package.metadata.summary
#   $NuspecTags = $nuspecFile.package.metadata.tags
   $NuspecTitle = $nuspecFile.package.metadata.title
#   $NuspecVersion = $nuspecFile.package.metadata.version

#   If ($NuspecTagRequest -eq "authors") {return $NuspecAuthors}
#   If ($NuspecTagRequest -eq "bugtrackerurl") {return $NuspecBugTrackerURL}
#   If ($NuspecTagRequest -eq "conflicts") {return $NuspecConflicts}
#   If ($NuspecTagRequest -eq "copyright") {return $NuspecCopyright}
#   If ($NuspecTagRequest -eq "dependencies") {return $NuspecDependencies} # Not fully implemented yet
#   If ($NuspecTagRequest -eq "description") {return $NuspecDescription}
#   If ($NuspecTagRequest -eq "docsurl") {return $NuspecDocsURL}
#   If ($NuspecTagRequest -eq "files") {return $NuspecFiles} # Not fully implemented yet
#   If ($NuspecTagRequest -eq "iconurl") {return $NuspecIconURL}
#   If ($NuspecTagRequest -eq "id") {return $NuspecID}
#   If ($NuspecTagRequest -eq "licenseurl") {return $NuspecLicenseURL}
#   If ($NuspecTagRequest -eq "mailinglisturl") {return $NuspecMailingListURL}
#   If ($NuspecTagRequest -eq "owners") {return $NuspecOwners}
#   If ($NuspecTagRequest -eq "packagesourceurl") {return $NuspecPackageSourceURL}
#   If ($NuspecTagRequest -eq "projectsourceurl") {return $NuspecProjectSourceURL}
#   If ($NuspecTagRequest -eq "projecturl") {return $NuspecProjectURL}
#   If ($NuspecTagRequest -eq "provides") {return $NuspecProvides}
#   If ($NuspecTagRequest -eq "releasenotes") {return $NuspecReleaseNotes}
#   If ($NuspecTagRequest -eq "replaces") {return $NuspecReplaces}
#   If ($NuspecTagRequest -eq "requirelicenseacceptance") {return $NuspecRequireLicenseAcceptance}
   If ($NuspecTagRequest -eq "summary") {return $NuspecSummary}
#   If ($NuspecTagRequest -eq "tags") {return $NuspecTags}
   If ($NuspecTagRequest -eq "title") {return $NuspecTitle}
#   If ($NuspecTagRequest -eq "version") {return $NuspecVersion}
}

# Write out the saved list of ALL installed programs to AllProgramsList.txt
Function Write-AllProgramsList{
    $header="All installed programs list generated by choco-package-list-backup on $Date.`n"
	$body=Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher
	Write-Output $header $body | Out-File "$SavePath\$AllProgramsListFile" -Encoding ASCII
	Write-Host "  ** $SavePath\$AllProgramsListFile SAVED!" -Foreground Green
# 2nd copy in format AllProgramsList_date.txt if AppendDate is set to true
	if ($AppendDate -eq "True"){
	    $AllProgramsListFileArchival = $AllProgramsListFile.Replace(".txt","")+"_$Date.txt"
	    Write-Output $header $body | Out-File "$SavePath\$AllProgramsListFileArchival" -Encoding ASCII
	    Write-Host "  ** $SavePath\$AllProgramsListFileArchival SAVED!" -Foreground Green
	   }
}  

# Write out pins.bat to easily re-pin previously pinned packages
Function Write-PinnedList{
	$header="@echo off`nrem pinned packages found by choco-package-list-backup.ps1 on $Date :`necho   ** Re-pinning previously pinned Chocolatey packages."
	if ($SaveVersions -match $True){
	    $body=choco pin list -r | % {"choco pin add -n=$($_.SubString(0, $_.IndexOf("|"))) --version $($_.SubString($_.IndexOf("|") + 1))"}
		} else {
		  $body=choco pin list -r | % {"choco pin add -n=$($_.SubString(0, $_.IndexOf("|")))"}
		}
	if ($body -match $ErrorArray[0-3]) {
	    Write-Warning "  ** Another instance of choco.exe was running and corrupted the output. Aborting..."
		throw
		}
	Write-Output $header $body | Out-File "$SavePath\$PinnedPackagesFile" -Encoding ASCII
	Write-Host "  ** $SavePath\$PinnedPackagesFile SAVED!" -Foreground Green
# 2nd copy in format pins_date.bat if AppendDate is set to true
	if ($AppendDate -eq "True"){
	    $PinnedPackagesFile = $PinnedPackagesFile.Replace(".bat","")+"_$Date.bat"
	    Write-Output $header $body | Out-File "$SavePath\$PinnedPackagesFile" -Encoding ASCII
	    Write-Host "  ** $SavePath\$PinnedPackagesFile SAVED!" -Foreground Green
	   }
}
  
# Write out the saved list of packages to packages.config
Function Write-PackagesConfig{
    Check-SaveLocation
	$header="<?xml version=`"1.0`" encoding=`"utf-8`"?>`n<packages>"	
	if (($SaveVersions -eq "True") -and ($SaveTitleSummary -eq "True")){
        $body=choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" title=""$(get-nuspecinfo "$($_.SubString(0, $_.IndexOf("|")))" "title")"" summary=""$(get-nuspecinfo "$($_.SubString(0, $_.IndexOf("|")))" "summary")""/>" }
	   }
	if (($SaveVersions -eq "True") -and ($SaveTitleSummary -eq "False")){
	    $body=choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }
	   }
	if (($SaveVersions -eq "False") -and ($SaveTitleSummary -eq "True")){
        $body=choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" title=""$(get-nuspecinfo "$($_.SubString(0, $_.IndexOf("|")))" "title")"" summary=""$(get-nuspecinfo "$($_.SubString(0, $_.IndexOf("|")))" "summary")""/>" }
	   }
	if (($SaveVersions -eq "False") -and ($SaveTitleSummary -eq "False")){
	    $body=choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`"/>" }
	   }
	$footer="</packages>"
	if ($body -match $ErrorArray[0-3]) {
	    Write-Warning "  ** Another instance of choco.exe was running and corrupted the output. Aborting..."
		throw
		}
	Write-Output $header $body $footer | Out-File "$SavePath\$PackagesListFile" -Encoding ASCII #ASCII is a subset of UTF8 (w/o BOM)
	Write-Host "  ** $SavePath\$PackagesListFile SAVED!" -Foreground Green
	
# 2nd copy in format packages.config_date.config if AppendDate is set to true	
	if ($AppendDate -eq "True"){
	    Write-Output $header $body $footer | Out-File "$SavePath\$PackagesListArchival" -Encoding ASCII #ASCII is a subset of UTF8 (w/o BOM)
		Write-Host "  ** $SavePath\$PackagesListArchival SAVED!" -Foreground Green
		}
    Copy-Config
	if ($PPCinstalled) {Copy-PPConfig}
	if ($SaveAllProgramsList -eq "True"){Write-AllProgramsList}
	if (!$PinnedPackages){Remove-Item "$SavePath\$PinnedPackagesFile" -ea SilentlyContinue | Out-Null }
	if ($PinnedPackages){Write-PinnedList}
	if ($ICinstalled) {Copy-InstChoco}
	Write-Host
}

# saves --------------------------------------------------------------------------------

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
   
# Backup Chocolatey package names on local computer to packages.config file in various OneDrive directories if they exists
if ($ENV:OneDrive) {$OneDriveExists="True"} else {$OneDriveExists="False"}
if ($UseOneDrive -match "True" -and ($OneDriveExists -match "True"))
   {
    $SavePath = "$ENV:OneDrive\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }
   
if ($ENV:OneDriveConsumer) {$OneDriveExists="True"} else {$OneDriveExists="False"}
if ($UseOneDrive -match "True" -and ($OneDriveExists -match "True"))
   {
    $SavePath = "$ENV:OneDriveConsumer\$SaveFolderName\$ENV:ComputerName"
    Write-PackagesConfig
   }
   
if ($ENV:OneDriveCommercial) {$OneDriveExists="True"} else {$OneDriveExists="False"}
if ($UseOneDrive -match "True" -and ($OneDriveExists -match "True"))
   {
    $SavePath = "$ENV:OneDriveCommercial\$SaveFolderName\$ENV:ComputerName"
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
   
# wrap up --------------------------------------------------------------------------------

If ($ICinstalled){
     Write-Host "To re-install your Chocolatey packages: run INSTCHOCO -Y`n" -Foreground Magenta
   } else {
     Write-Host "  ** Consider getting InstChoco - The ULTIMATE Chocolatey and Chocolatey packages (re)installer!`n  ** https://chocolatey.org/packages/InstChoco`n" -Foreground Cyan
     Write-Host "To re-install your Chocolatey packages: run CHOCO INSTALL PACKAGES.CONFIG -Y`n" -Foreground Magenta
   }
Write-Host "Found choco-package-list-backup.ps1 useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White
Start-Sleep -s 10 # Gives time to view before closing when run from Windows Start Menu shortcut
