$ErrorActionPreference = 'Stop'
# Choco-Package-List-Backup.ps1 Copyleft 2017-2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

Write-Host "Choco-Package-List-Backup.ps1 v2023.06.28 - backup Chocolatey packages list locally and to the cloud" -Foreground White
Write-Host "Copyleft 2017-2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White
Write-Host "Choco Package List Backup Summary:`n" -Foreground Magenta

# Set Notepad++ as preferred editor/viewer
if (Test-Path $env:ChocolateyInstall\bin\notepad++.exe){
     $Editor="notepad++.exe"
    } else {
      $Editor="notepad.exe"
    }

# Easily edit the config file
if ($args -eq "-EditConfig") {
    Write-Host "  ** Editing contents of choco-package-list-backup.config." -Foreground Magenta
	&$Editor "$env:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.config"
	return
}

# Easily view the log file
if ($args -eq "-ViewLog"){
	Write-Host "  ** Showing contents of choco-package-list-backup.log." -Foreground Magenta
	&$Editor "$ENV:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log"
	return
}

##### VARIABLES BEGIN

# Verify ChocolateyToolsLocation was created by Get-ToolsLocation during install and is in the environment
if (!$env:ChocolateyToolsLocation) {$env:ChocolateyToolsLocation = "$env:SystemDrive\tools"}

$Date           = Get-Date -UFormat %Y-%m-%d
$ErrorArray     = @("this is try","error converted","access to path") #errors caused by Chocolatey not being multi-instance aware (Hopefully in v1.0!)
$ICinstalled    = Test-Path "$env:ChocolateyInstall\lib\instchoco\tools\InstChoco.exe"
$PinnedPackages = choco pin list -r
$PinnedPackagesFile = 'pins.bat'
$PPCinstalled   = Test-Path "$env:ChocolateyInstall\config\persistentpackages.config"
$scriptDir      = "$env:ChocolateyToolsLocation\BCURRAN3"
$ScriptConfig   = 'choco-package-list-backup.config'

# Set default preferences in case of corrupt or missing choco-package-list-backup.config
$PackagesListFile    = 'packages.config'
$SaveFolderName      = 'ChocolateyPackageListBackup'
$SaveArguments       = $False
$SaveTitleSummary    = $False
$SaveVersions        = $False
$AppendDate          = $False
$CustomPath          = 'c:\install'
$CustomPath2         = 'c:\backup'
$SaveAllProgramsList = $True
$AllProgramsListFile = 'AllProgramsList.txt'
$DefaultUserProfile  = ''
$PreProcessScript    = ''
$PostProcessScript   = ''

$UseCustomPath  = $False
$UseCustomPath2 = $False
$UseDocuments   = $True
$UseHomeShare   = $True
$UseBox         = $True
$UseDropbox     = $True
$UseGoogleDrive = $True
$UseiCloudDrive = $True
$UseNextcloud   = $True
$UseOneDrive    = $True
$UseownCloud    = $True
$UseReadyCLOUD  = $True
$UseResilioSync = $True
$UseSeafile     = $True
$UseTonidoSync  = $True
$UseDefaultUserProfile = $False

# Import preferences - see comments in choco-package-list-backup.config for settings
if (Test-Path "$scriptDir\choco-package-list-backup.config") {
   [xml]$ConfigFile     = Get-Content "$scriptDir\choco-package-list-backup.config"
   $PackagesListFile    = $ConfigFile.Settings.Preferences.PackagesListFile
   $SaveFolderName      = $ConfigFile.Settings.Preferences.SaveFolderName
   if ($ConfigFile.Settings.Preferences.SaveArguments -eq "true") {$SaveArguments=$True} else {$SaveArguments=$False}
   if ($ConfigFile.Settings.Preferences.SaveTitleSummary -eq "true") {$SaveTitleSummary=$True} else {$SaveTitleSummary=$False}
   if ($ConfigFile.Settings.Preferences.SaveVersions -eq "true") {$SaveVersions=$True} else {$SaveVersions=$False}
   if ($ConfigFile.Settings.Preferences.AppendDate -eq "true") {$AppendDate=$True} else {$AppendDate=$False}
   $CustomPath          = $ConfigFile.Settings.Preferences.CustomPath
   $CustomPath2         = $ConfigFile.Settings.Preferences.CustomPath2
   if ($ConfigFile.Settings.Preferences.SaveAllProgramsList -eq "true") {$SaveAllProgramsList=$True} else {$SaveAllProgramsList=$False}
   $AllProgramsListFile = $ConfigFile.Settings.Preferences.AllProgramsListFile
   $DefaultUserProfile  = $ConfigFile.Settings.Preferences.DefaultUserProfile
   $PreProcessScript    = $ConfigFile.Settings.Preferences.PreProcessScript
   $PostProcessScript   = $ConfigFile.Settings.Preferences.PostProcessScript

   if ($ConfigFile.Settings.Preferences.UseCustomPath -eq "true") {$UseCustomPath=$True} else {$UseCustomPath=$False}
   if ($ConfigFile.Settings.Preferences.UseCustomPath2 -eq "true") {$UseCustomPath2=$True} else {$UseCustomPath2=$False}
   if ($ConfigFile.Settings.Preferences.UseDocuments -eq "true") {$UseDocuments=$True} else {$UseDocuments=$False}
   if ($ConfigFile.Settings.Preferences.UseHomeShare -eq "true") {$UseHomeShare=$True} else {$UseHomeShare=$False}
   if ($ConfigFile.Settings.Preferences.UseBox -eq "true") {$UseBox=$True} else {$UseBox=$False}
   if ($ConfigFile.Settings.Preferences.UseDropbox -eq "true") {$UseDropbox=$True} else {$UseDropbox=$False}
   if ($ConfigFile.Settings.Preferences.UseGoogleDrive -eq "true") {$UseGoogleDrive=$True} else {$UseGoogleDrive=$False}
   if ($ConfigFile.Settings.Preferences.UseiCloudDrive -eq "true") {$UseiCloudDrive=$True} else {$UseiCloudDrive=$False}
   if ($ConfigFile.Settings.Preferences.UseNextcloud -eq "true") {$UseNextcloud=$True} else {$UseNextcloud=$False}
   if ($ConfigFile.Settings.Preferences.UseOneDrive -eq "true") {$UseOneDrive=$True} else {$UseOneDrive=$False}
   if ($ConfigFile.Settings.Preferences.UseownCloud -eq "true") {$UseownCloud=$True} else {$UseownCloud=$False}
   if ($ConfigFile.Settings.Preferences.UseReadyCLOUD -eq "true") {$UseReadyCLOUD=$True} else {$UseReadyCLOUD=$False}
   if ($ConfigFile.Settings.Preferences.UseResilioSync -eq "true") {$UseResilioSync=$True} else {$UseResilioSync=$False}
   if ($ConfigFile.Settings.Preferences.UseSeafile -eq "true") {$UseSeafile=$True} else {$UseSeafile=$False}
   if ($ConfigFile.Settings.Preferences.UseTonidoSync -eq "true") {$UseTonidoSync=$True} else {$UseTonidoSync=$False}
   if ($ConfigFile.Settings.Preferences.UseDefaultUserProfile -eq "true") {$UseDefaultUserProfile=$True} else {$UseDefaultUserProfile=$False}
   } else { 
     Write-Warning "   ** choco-package-list-backup.config not found, using defaults." 
}

if ($AppendDate){
    if ($PackagesListFile -eq "packages.config"){
		 $PackagesListArchival = "packages_$Date.config"
		} else {
		  $PackagesListArchival = $PackagesListFile+"_$Date.config"
		}
}
 
if ($SaveAllProgramsList) {
    $SaveAllProgramsBody = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher
}    
 
# When running as SYSTEM (scheduled task) use the $DefaultUserProfile as the default user profile if defined
if ($DefaultUserProfile -and $UseDefaultUserProfile) {
	$env:USERPROFILE = "$env:SystemDrive\Users\$DefaultUserProfile"
	$env:APPDATA = "$env:SystemDrive\Users\$DefaultUserProfile\AppData\Roaming"
}

##### VARIABLES END
##### FUNCTIONS BEGIN

# add to log file
function Add2Log {
  Param ( [string]$comment )

  Write-Output "$(Get-Date) [INFO ] $comment" >> "$ENV:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log"
}

# Check the path to save packages.config and create if it doesn't exist
Function Check-SaveLocation{
  if (!(Test-Path $SavePath)) {New-Item $SavePath -Type Directory -Force | Out-Null}   
}

# Copy choco-package-list-backup.config to the same location as packages.config
Function Copy-Config{
  if (Test-Path "$scriptDir\choco-package-list-backup.config") {
      if (Test-Path "$SavePath\choco-package-list-backup.config.bak") {Remove-Item "$SavePath\choco-package-list-backup.config.bak"}
      if (Test-Path "$SavePath\choco-package-list-backup.config") {Rename-Item "$SavePath\choco-package-list-backup.config" "$SavePath\choco-package-list-backup.config.bak"}
      Copy-Item "$scriptDir\$ScriptConfig" $SavePath -Force | Out-Null
      Write-Host "  ** $SavePath\$ScriptConfig SAVED!" -Foreground Green
	  Add2Log "SAVED: $SavePath\$ScriptConfig"
     }
}

# Copy persistentpackages.config if it exists to the same location as packages.config
Function Copy-PPConfig{
   if (Test-Path "$SavePath\persistentpackages.config.bak") {Remove-Item "$SavePath\persistentpackages.config.bak"}
   if (Test-Path "$SavePath\persistentpackages.config") {Rename-Item "$SavePath\persistentpackages.config" "$SavePath\persistentpackages.config.bak"}
   Copy-Item $env:ChocolateyInstall\config\persistentpackages.config $SavePath -Force | Out-Null
   Write-Host "  ** $SavePath\persistentpackages.config SAVED!" -Foreground Green 
   Add2Log "SAVED: $SavePath\persistentpackages.config"
}
	
# Copy InstChoco.exe if it exists to the same location as packages.config for super duper easy re-installation
Function Copy-InstChoco{
    $InstChoco = "$env:ChocolateyInstall\lib\instchoco\tools\InstChoco.exe" # location of InstChoco.exe if it exists
    if (!(Test-Path $SavePath\InstChoco.exe))
       {
        Copy-Item $InstChoco $SavePath -Force | Out-Null
        Write-Host "  ** $SavePath\InstChoco.exe COPIED!" -Foreground Green
		Add2Log "COPIED: $SavePath\InstChoco.exe"
	   } else {
	     $ICSource = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($InstChoco).FileVersion
	     $ICDest = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("$SavePath\InstChoco.exe").FileVersion
	     if ($ICSource -ne $ICDest)
	        {
	         Copy-Item $InstChoco $SavePath -Force | Out-Null
	         Write-Host "  ** $SavePath\InstChoco.exe COPIED!" -Foreground Green
			 Add2Log "COPIED: $SavePath\InstChoco.exe"
	        }
	   }
}

#Un-encrypt .arguments file
Add-Type -AssemblyName System.Security
$entropyBytes = [System.Text.UTF8Encoding]::UTF8.GetBytes("Chocolatey")
Function Unprotect-Arguments {
    param([string]$data)
    $encryptedByteArray = [System.Convert]::FromBase64String($data)
    $decryptedByteArray = [System.Security.Cryptography.ProtectedData]::Unprotect(
        $encryptedByteArray,
        $entropyBytes,
        [System.Security.Cryptography.DataProtectionScope]::LocalMachine
    )
    return [System.Text.UTF8Encoding]::UTF8.GetString($decryptedByteArray)
}

function Read-Arguments {
    param([string]$packageName)
    $directory = Get-ChildItem $env:ChocolateyInstall\.chocolatey -Directory -Filter "$packageName*" | `
        Where-Object { $_.Name -match ("$packageName" + "\.[\d\.]+") } | Select-Object -Last 1
    if (!($directory)) { return }
    $argsFile = Join-Path $directory.fullname ".arguments"
    if (Test-Path $argsFile) {
        $argsData = Get-Content $argsFile
        #Implicitly return result from Unprotect-Arguments
        Unprotect-Arguments -data $argsData
    }
}

# Import package.nuspec file to get extended package info
function Get-NuspecInfo($PackageName,$NuspecTagRequest){
   $nuspecXML = "$env:ChocolateyInstall\lib\$PackageName\$PackageName.nuspec"
   if (!(Test-Path $nuspecXML)) { return "Unknown" }
   [xml]$nuspecFile = Get-Content $nuspecXML
#   $NuspecAuthors          = $nuspecFile.package.metadata.authors
#   $NuspecBugTrackerURL    = $nuspecFile.package.metadata.bugtrackerurl
#   $NuspecConflicts        = $nuspecFile.package.metadata.conflicts # Built for the future
#   $NuspecCopyright        = $nuspecFile.package.metadata.copyright
#   $NuspecDependencies     = $nuspecFile.package.metadata.dependencies # Not fully implemented yet
#   $NuspecDescription      = $nuspecFile.package.metadata.description
#   $NuspecDocsURL          = $nuspecFile.package.metadata.docsurl
#   $NuspecFiles            = $nuspecFile.package.files.file # Not fully implemented yet
#   $NuspecIconURL          = $nuspecFile.package.metadata.iconurl
#   $NuspecID               = $nuspecFile.package.metadata.id
#   $NuspecLicenseURL       = $nuspecFile.package.metadata.licenseurl
#   $NuspecMailingListURL   = $nuspecFile.package.metadata.mailinglisturl
#   $NuspecOwners           = $nuspecFile.package.metadata.owners
#   $NuspecPackageSourceURL = $nuspecFile.package.metadata.packagesourceurl
#   $NuspecProjectSourceURL = $nuspecFile.package.metadata.projectsourceurl
#   $NuspecProjectURL       = $nuspecFile.package.metadata.projecturl
#   $NuspecProvides         = $nuspecFile.package.metadata.provides # Built for the future
#   $NuspecReleaseNotes     = $nuspecFile.package.metadata.releasenotes
#   $NuspecReplaces         = $nuspecFile.package.metadata.replaces # Built for the future
#   $NuspecRequireLicenseAcceptance = $nuspecFile.package.metadata.requirelicenseacceptance
   $NuspecSummary          = $nuspecFile.package.metadata.summary
#   $NuspecTags             = $nuspecFile.package.metadata.tags
   $NuspecTitle            = $nuspecFile.package.metadata.title
#   $NuspecVersion          = $nuspecFile.package.metadata.version

#   if ($NuspecTagRequest -eq "authors") {return $NuspecAuthors}
#   if ($NuspecTagRequest -eq "bugtrackerurl") {return $NuspecBugTrackerURL}
#   if ($NuspecTagRequest -eq "conflicts") {return $NuspecConflicts}
#   if ($NuspecTagRequest -eq "copyright") {return $NuspecCopyright}
#   if ($NuspecTagRequest -eq "dependencies") {return $NuspecDependencies} # Not fully implemented yet
#   if ($NuspecTagRequest -eq "description") {return $NuspecDescription}
#   if ($NuspecTagRequest -eq "docsurl") {return $NuspecDocsURL}
#   if ($NuspecTagRequest -eq "files") {return $NuspecFiles} # Not fully implemented yet
#   if ($NuspecTagRequest -eq "iconurl") {return $NuspecIconURL}
#   if ($NuspecTagRequest -eq "id") {return $NuspecID}
#   if ($NuspecTagRequest -eq "licenseurl") {return $NuspecLicenseURL}
#   if ($NuspecTagRequest -eq "mailinglisturl") {return $NuspecMailingListURL}
#   if ($NuspecTagRequest -eq "owners") {return $NuspecOwners}
#   if ($NuspecTagRequest -eq "packagesourceurl") {return $NuspecPackageSourceURL}
#   if ($NuspecTagRequest -eq "projectsourceurl") {return $NuspecProjectSourceURL}
#   if ($NuspecTagRequest -eq "projecturl") {return $NuspecProjectURL}
#   if ($NuspecTagRequest -eq "provides") {return $NuspecProvides}
#   if ($NuspecTagRequest -eq "releasenotes") {return $NuspecReleaseNotes}
#   if ($NuspecTagRequest -eq "replaces") {return $NuspecReplaces}
#   if ($NuspecTagRequest -eq "requirelicenseacceptance") {return $NuspecRequireLicenseAcceptance}
   if ($NuspecTagRequest -eq "summary") {return $NuspecSummary}
#   if ($NuspecTagRequest -eq "tags") {return $NuspecTags}
   if ($NuspecTagRequest -eq "title") {return $NuspecTitle}
#   if ($NuspecTagRequest -eq "version") {return $NuspecVersion}
}

# Write out the saved list of ALL installed programs to AllProgramsList.txt
Function Write-AllProgramsList{
    $header="All installed programs list generated by choco-package-list-backup on $Date.`n"
	if (Test-Path "$SavePath\$AllProgramsListFile.bak") {Remove-Item "$SavePath\$AllProgramsListFile.bak"}
	if (Test-Path "$SavePath\$AllProgramsListFile") {Rename-Item "$SavePath\$AllProgramsListFile" "$SavePath\$AllProgramsListFile.bak"}
	Write-Output $header $SaveAllProgramsBody | Out-File "$SavePath\$AllProgramsListFile" -Encoding ASCII
	Write-Host "  ** $SavePath\$AllProgramsListFile SAVED!" -Foreground Green
	Add2Log "SAVED: $SavePath\$AllProgramsListFile"
# 2nd copy in format AllProgramsList_date.txt if AppendDate is set to true
	if ($AppendDate -eq "True"){
	    $AllProgramsListFileArchival = $AllProgramsListFile.Replace(".txt","")+"_$Date.txt"
	    Write-Output $header $SaveAllProgramsBody | Out-File "$SavePath\$AllProgramsListFileArchival" -Encoding ASCII
	    Write-Host "  ** $SavePath\$AllProgramsListFileArchival SAVED!" -Foreground Green
		Add2Log "SAVED: $SavePath\$AllProgramsListFileArchival"
	   }
}  

# Write out pins.bat to easily re-pin previously pinned packages
Function Write-PinnedList{
	$header="@echo off`nrem pinned packages found by choco-package-list-backup.ps1 on $Date :`necho   ** Re-pinning previously pinned Chocolatey packages."
	if ($SaveVersions){
	    $body=$PinnedPackages | % {"choco pin add -n=$($_.SubString(0, $_.IndexOf("|"))) --version $($_.SubString($_.IndexOf("|") + 1))"}
		} else {
		  $body=$PinnedPackages | % {"choco pin add -n=$($_.SubString(0, $_.IndexOf("|")))"}
		}
	if ($body -Match $ErrorArray[0-3]) {
	    Write-Warning "  ** Another instance of choco.exe was running and corrupted the output. Aborting..."
		throw
		}
	if (Test-Path "$SavePath\$PinnedPackagesFile.bak") {Remove-Item "$SavePath\$PinnedPackagesFile.bak"}
	if (Test-Path "$SavePath\$PinnedPackagesFile") {Rename-Item "$SavePath\$PinnedPackagesFile" "$SavePath\$PinnedPackagesFile.bak"}
	Write-Output $header $body | Out-File "$SavePath\$PinnedPackagesFile" -Encoding ASCII
	Write-Host "  ** $SavePath\$PinnedPackagesFile SAVED!" -Foreground Green
	Add2Log "SAVED: $SavePath\$PinnedPackagesFile"
# 2nd copy in format pins_date.bat if AppendDate is set to true
	if ($AppendDate -eq "True"){
	    $PinnedPackagesFile = $PinnedPackagesFile.Replace(".bat","")+"_$Date.bat"
	    Write-Output $header $body | Out-File "$SavePath\$PinnedPackagesFile" -Encoding ASCII
	    Write-Host "  ** $SavePath\$PinnedPackagesFile SAVED!" -Foreground Green
		Add2Log "SAVED: $SavePath\$PinnedPackagesFile"
	   }
}
  
# Write out the saved list of packages to packages.config
Function Write-PackagesConfig{
    Check-SaveLocation
	$header="<?xml version=`"1.0`" encoding=`"utf-8`"?>`n<packages>"
	$footer="</packages>"
	if ($body -Match $ErrorArray[0-3]) {
	    Write-Warning "  ** Another instance of choco.exe was running and corrupted the output. Aborting..."
		throw
		}
    if (Test-Path "$SavePath\$PackagesListFile.bak") {Remove-Item "$SavePath\$PackagesListFile.bak"}
	if (Test-Path "$SavePath\$PackagesListFile") {Rename-Item "$SavePath\$PackagesListFile" "$SavePath\$PackagesListFile.bak"}
	Write-Output $header $PackagesConfigBody $footer | Out-File "$SavePath\$PackagesListFile" -Encoding ASCII #ASCII is a subset of UTF8 (w/o BOM)
	Write-Host "  ** $SavePath\$PackagesListFile SAVED!" -Foreground Green
	Add2Log "SAVED: $SavePath\$PackagesListFile"
	
# 2nd copy in format packages.config_date.config if AppendDate is set to true	
	if ($AppendDate -eq "True"){
	    Write-Output $header $PackagesConfigBody $footer | Out-File "$SavePath\$PackagesListArchival" -Encoding ASCII #ASCII is a subset of UTF8 (w/o BOM)
		Write-Host "  ** $SavePath\$PackagesListArchival SAVED!" -Foreground Green
		Add2Log "SAVED: $SavePath\$PackagesListArchival"
		}
    Copy-Config
	if ($PPCinstalled) {Copy-PPConfig}
	if ($SaveAllProgramsList){Write-AllProgramsList}
	if (!$PinnedPackages){Remove-Item "$SavePath\$PinnedPackagesFile" -EA SilentlyContinue | Out-Null }
	if ($PinnedPackages){Write-PinnedList}
	if ($ICinstalled) {Copy-InstChoco}
	Write-Host
}

##### FUNCTIONS END
##### START PROCESSING

# Start logging
if (Test-Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log"){
   $LogSize=(Get-ChildItem -Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log").length
   if ($LogSize -gt 40960) {
	   Remove-Item "$env:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log" -ErrorAction SilentlyContinue
	   Write-Output "$(Get-Date) Choco-Package-List-Backup Deleted log file" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log"
	  }
   Write-Output "----------------------------------------------------------------------" >> "$ENV:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log"
   Write-Output "$(Get-Date) Choco-Package-List-Backup STARTED" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log"
}

# Run pre-processor if configured
if ($PreProcessScript) {
	Add2Log "CONFIG: PreProcessScript is set to `"$PreProcessScript`""
	Add2Log "RUNNING: $PreProcessScript."
	&$PreProcessScript
}

# Get list of installed packages
# Handle choco list v0-1/v2+ differently
if ([System.Diagnostics.FileVersionInfo]::GetVersionInfo("$env:ChocolateyInstall\choco.exe").ProductMajorPart -gt 1){
	 $localPackageInfo = & choco list -r -y
	} else {
		$localPackageInfo = & choco list -lo -r -y
}

# Process list of installed packages for package.config
if ($SaveTitleSummary) { Add2Log "CONFIG: SaveTitleSummary is set to $SaveTitleSummary" }
if ($SaveArguments) { Add2Log "CONFIG: SaveArguments is set to $SaveArguments" }
$PackagesConfigBody = $localPackageInfo | % {
    $packageName = $($_.SubString(0, $_.IndexOf("|")))
    $line = '   <package id="' + $packageName + '" '
    if ($SaveTitleSummary) {
        $line = $line + 'title="' + [System.Security.SecurityElement]::Escape($(get-nuspecinfo "$($_.SubString(0, $_.IndexOf("|")))" "title")) + '" '
        $line = $line + 'summary="' + [System.Security.SecurityElement]::Escape($(get-nuspecinfo "$($_.SubString(0, $_.IndexOf("|")))" "summary")) + '" '
    }
    if ($SaveArguments) {
        $line = $line + 'arguments="' + [System.Security.SecurityElement]::Escape($(Read-Arguments $packageName)) + '" '
    }
    $line = $line + '/>'
    $line
}

##### START SAVE BACKUPS

# Backup Chocolatey package names to packages.config file in custom defined path you set as CustomPath in the config file
if ($UseCustomPath) {Add2Log "CONFIG: UseCustomPath is set to $UseCustomPath"}
if ($UseCustomPath -and (Test-Path $CustomPath))
   {
    $SavePath   = "$CustomPath\$SaveFolderName"
	Write-Host "  ** Saving to CUSTOMPATH:" -Foreground Green
    Write-PackagesConfig
   }

# Backup Chocolatey package names to packages.config file in custom defined path you set as CustomPath in the config file
if ($UseCustomPath2) {Add2Log "CONFIG: UseCustomPath2 is set to $UseCustomPath2"}
if ($UseCustomPath2 -and (Test-Path $CustomPath2))
   {
    $SavePath   = "$CustomPath2\$SaveFolderName"
	Write-Host "  ** Saving to CUSTOMPATH2:" -Foreground Green
    Write-PackagesConfig
   }

# Backup Chocolatey package names on local computer to packages.config file in the Documents folder
if ($UseDocuments) {Add2Log "CONFIG: UseDocuments is set to $UseDocuments"}
if ($env:COMPUTERNAME -eq $env:USERNAME.trim('$')) { $DocumentsFolder = "$env:PUBLIC\Documents" } else { $DocumentsFolder = [Environment]::GetFolderPath("MyDocuments") }
if (($DefaultUserProfile) -and ($UseDefaultUserProfile)) { $DocumentsFolder = "$env:USERPROFILE\Documents" }
if ($DocumentsFolder -ne ""){
   if ($UseDocuments -and (Test-Path $DocumentsFolder))
       {
		Add2Log "CONFIG: DocumentsFolder is set to `"$DocumentsFolder`""
        $SavePath   = "$DocumentsFolder\$SaveFolderName"
		Write-Host "  ** Saving to DOCUMENTS:" -Foreground Green
        Write-PackagesConfig
       }
   } 
   
# Backup Chocolatey package names on local computer to packages.config file in Box (Sync) directory if it exists
if ($UseBox) {Add2Log "CONFIG: UseBox is set to $UseBox"}
if ($UseBox -and (Test-Path "$env:USERPROFILE\Box Sync"))
   {
    $SavePath = "$env:USERPROFILE\Box Sync\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to BOX SYNC:" -Foreground Green
    Write-PackagesConfig
   }

# Backup Chocolatey package names on local computer to packages.config file in Box (Drive) directory if it exists
if ($UseBox -and (Test-Path "$env:USERPROFILE\Box"))
   {
    $SavePath = "$env:USERPROFILE\Box\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to BOX:" -Foreground Green
    Write-PackagesConfig
   }

# Check for Dropbox personal and business paths (Thanks ebbek!)
if ($UseDropbox) {Add2Log "CONFIG: UseDropbox is set to $UseDropbox"}
if (Test-Path $env:AppData\Dropbox\info.json)
   {
    $DropboxPersonal = ((Get-Content $env:AppData\Dropbox\info.json) -join '`n' | ConvertFrom-json).personal.path
    $DropboxBusiness = ((Get-Content $env:AppData\Dropbox\info.json) -join '`n' | ConvertFrom-json).business.path
   }
Elseif (Test-Path $env:LocalAppData\Dropbox\info.json)
   {
    $DropboxPersonal = ((Get-Content $env:LocalAppData\Dropbox\info.json) -join '`n' | ConvertFrom-json).personal.path
    $DropboxBusiness = ((Get-Content $env:LocalAppData\Dropbox\info.json) -join '`n' | ConvertFrom-json).business.path
   }

# Backup Chocolatey package names on local computer to packages.config file in Personal Dropbox directory if it exists
if ($UseDropbox -and ($DropboxPersonal) -and (Test-Path $DropboxPersonal))
   {
    $SavePath = "$DropboxPersonal\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to DROPBOX:" -Foreground Green
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Business Dropbox directory if it exists
if ($UseDropbox -and ($DropboxBusiness) -and (Test-Path $DropboxBusiness))
   {
    $SavePath = "$DropboxBusiness\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to DROPBOX (Business):" -Foreground Green
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Google Drive/Backup and Sync directory if it exists
if ($UseGoogleDrive) {Add2Log "CONFIG: UseGoogleDrive is set to $UseGoogleDrive"}
if ($UseGoogleDrive -and (Test-Path "$env:USERPROFILE\Google Drive"))   
   {
    $SavePath = "$env:USERPROFILE\Google Drive\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to GOOGLE DRIVE:" -Foreground Green
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Google Drive FS "My Drive" directory if it exists (Thanks ebbek!)
$GFSInstalled=(Test-Path -path HKCU:Software\Google\DriveFS\Share)
if ($GFSInstalled)
   {
    $GoogleFSmountpoint = (Get-ItemProperty -path Registry::HKEY_CURRENT_USER\Software\Google\DriveFS\Share).MountPoint
    if ($UseGoogleDrive -and $GoogleFSmountpoint -and (Test-Path "${GoogleFSmountpoint}:\My Drive"))
       {
        $SavePath = "${GoogleFSmountpoint}:\My Drive\$SaveFolderName\$env:COMPUTERNAME"
		Write-Host "  ** Saving to GOOGLE DRIVE FS:" -Foreground Green
        Write-PackagesConfig
       }
	}
   
# Backup Chocolatey package names on local computer to packages.config file on your HOMESHARE directory if it exists
# NOTE: Won't work when running as SYSTEM
if ($UseHomeShare) {Add2Log "CONFIG: UseHomeShare is set to $UseHomeShare"}
if ($env:HOMESHARE) {$ExistHomeShare=$True} else {$ExistHomeShare=$False}
if ($UseHomeShare -and $ExistHomeShare)   
   {
    $SavePath = "$env:HOMESHARE\$SaveFolderName\$env:COMPUTERNAME"   
	Write-Host "  ** Saving to HOMESHARE:" -Foreground Green
    Write-PackagesConfig
   }      

# Backup Chocolatey package names on local computer to packages.config file in iCloudDrive directory if it exists
if ($UseiCloudDrive) {Add2Log "CONFIG: UseiCloudDrive is set to $UseiCloudDrive"}
if ($UseiCloudDrive -and (Test-Path $env:USERPROFILE\iCloudDrive))
   {
    $SavePath = "$env:USERPROFILE\iCloudDrive\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to ICLOUD:" -Foreground Green
    Write-PackagesConfig
   }    
   
# Backup Chocolatey package names on local computer to packages.config file in Nextcloud directory if it exists
if ($UseNextcloud) {Add2Log "CONFIG: UseNextcloud is set to $UseNextcloud"}
if ($UseNextcloud -and (Test-Path $env:USERPROFILE\Nextcloud))
   {
    $SavePath = "$env:USERPROFILE\Nextcloud\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to NEXTCLOUD:" -Foreground Green
    Write-PackagesConfig
   } 
   
# Backup Chocolatey package names on local computer to packages.config file in various OneDrive directories if they exists
if ($UseOneDrive) {Add2Log "CONFIG: UseOneDrive is set to $UseOneDrive"}
$OneDriveWritten=$False
if ($env:OneDrive) {$OneDriveExists=$True} else {$OneDriveExists=$False}
if ($UseOneDrive -and $OneDriveExists)
   {
    $SavePath = "$env:OneDrive\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to ONEDRIVE:" -Foreground Green
    Write-PackagesConfig
	$OneDriveWritten=$True
   }

if (Test-Path $env:USERPROFILE\OneDrive) {$OneDriveExists=$True} else {$OneDriveExists=$False}
if ($UseOneDrive -and $OneDriveExists)
   {
	if (!$OneDriveWritten)
	   {
        $SavePath = "$env:USERPROFILE\OneDrive\$SaveFolderName\$env:COMPUTERNAME"
		Write-Host "  ** Saving to ONEDRIVE:" -Foreground Green
        Write-PackagesConfig
	   }
   }
   
if ($env:OneDriveConsumer) {$OneDriveExists=$True} else {$OneDriveExists=$False}
if ($UseOneDrive -and $OneDriveExists)
   {
    $SavePath = "$env:OneDriveConsumer\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to ONEDRIVE:" -Foreground Green
    Write-PackagesConfig
   }
   
if ($env:OneDriveCommercial) {$OneDriveExists=$True} else {$OneDriveExists=$False}
if ($UseOneDrive -and $OneDriveExists)
   {
    $SavePath = "$env:OneDriveCommercial\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to ONEDRIVE (Business):" -Foreground Green
    Write-PackagesConfig
   }

# Backup Chocolatey package names on local computer to packages.config file in ownCloud directory if it exists
if ($UseownCloud) {Add2Log "CONFIG: UseownCloud is set to $UseownCloud"}
if ($UseownCloud -and (Test-Path "$env:USERPROFILE\ownCloud"))
   {
    $SavePath = "$env:USERPROFILE\ownCloud\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to OWNCLOUD:" -Foreground Green
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in Netgear ReadyCLOUD directory if it exists
if ($UseReadyCLOUD) {Add2Log "CONFIG: UseReadyCLOUD is set to $UseReadyCLOUD"}
if ($UseReadyCLOUD -and (Test-Path $env:USERPROFILE\ReadyCLOUD))
   {
    $SavePath = "$env:USERPROFILE\ReadyCLOUD\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to READYCLOUD:" -Foreground Green
    Write-PackagesConfig
   }

# Backup Chocolatey package names on local computer to packages.config file in Resilio Sync directory if it exists
if ($UseResilioSync) {Add2Log "CONFIG: UseResilioSync is set to $UseResilioSync"}
if ($UseResilioSync -and (Test-Path "$env:USERPROFILE\Resilio Sync"))
   {
    $SavePath = "$env:USERPROFILE\Resilio Sync\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to RESILIO SYNC:" -Foreground Green
    Write-PackagesConfig
   }   

# Backup Chocolatey package names on local computer to packages.config file in Seafile directory if it exists
if ($UseSeafile) {Add2Log "CONFIG: UseSeafile is set to $UseSeafile"}
if ($UseSeafile -and (Test-Path $env:USERPROFILE\Documents\Seafile))
   {
    $SavePath = "$env:USERPROFILE\Seafile\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to SEAFILE:" -Foreground Green
    Write-PackagesConfig
   }
   
# Backup Chocolatey package names on local computer to packages.config file in TonidoSync directory if it exists
if ($UseTonidoSync) {Add2Log "CONFIG: UseTonidoSync is set to $UseTonidoSync"}
if ($UseTonidoSync -and (Test-Path $env:USERPROFILE\Documents\TonidoSync))
   {
    $SavePath = "$env:USERPROFILE\Documents\TonidoSync\$SaveFolderName\$env:COMPUTERNAME"
	Write-Host "  ** Saving to TONIDO SYNC:" -Foreground Green
    Write-PackagesConfig
   }

##### SAVE BACKUPS END
##### WRAP UP

# Run post-processor if configured
if ($PostProcessScript) {
	Add2Log "CONFIG: PostProcessScript is set to `"$PostProcessScript`""
	Add2Log "RUNNING: $PostProcessScript"
	&$PostProcessScript
	}

if ($ICinstalled){
     Write-Host "To re-install your Chocolatey packages: run INSTCHOCO -Y`n" -Foreground Magenta
   } else {
     Write-Host "  ** Consider getting InstChoco - The ULTIMATE Chocolatey and Chocolatey packages (re)installer!`n  ** https://community.chocolatey.org/packages/instchoco`n" -Foreground Cyan
     Write-Host "To re-install your Chocolatey packages: run CHOCO INSTALL PACKAGES.CONFIG -Y`n" -Foreground Magenta
   }
Write-Host "Found Choco-Package-List-Backup.ps1 useful?" -Foreground White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -Foreground White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -Foreground White
if (Test-Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log"){
   Write-Output "$(Get-Date) Choco-Package-List-Backup FINISHED" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-package-list-backup.log"
}
Start-Sleep -s 10 # Gives time to view before closing when run from Windows Start Menu shortcut
