#backup-choco-package-list (to cloud) by Bill Curran v2017.08.08
#
# Toggle True/False if you want to backup to the locations below
$UseDocuments   = "False"
$UseDropbox     = "False"
$UseGoogleDrive = "False"
$UseHomeShare   = "True" # Domain HOMEDRIVE support
$UseOneDrive    = "False"
$UseReadyCLOUD  = "False"
$UseTonidoSync  = "False"
$UseVersions    = "False" # Specify if you want to save version information or not

Write-Host

# Backup Chocolatey package names on local computer to packages.config file in the Documents folder
if ($UseDocuments -match "True" -and (Test-Path $Env:USERPROFILE\Documents))
   {
    $SavePath = Test-Path $Env:USERPROFILE\Documents\ChocoPackagesBackup
	If ($SavePath -match "False")
	   {
	    New-Item $Env:USERPROFILE\Documents\ChocoPackagesBackup -Type Directory -force | out-null
	   }   
    $ConfigFile = "$Env:USERPROFILE\Documents\ChocoPackagesBackup\packages.config"
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>" >$ConfigFile
    Write-Output "<packages>" >>$ConfigFile
	if ($UseVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }>>$ConfigFile
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" }>>$ConfigFile
		 }
    Write-Output "</packages>" >>$ConfigFile
	Write-Host "$ConfigFile SAVED!" -ForegroundColor green 
   }

# Backup Chocolatey package names on local computer to packages.config file in Dropbox
if ($UseDropbox -match "True" -and (Test-Path $Env:USERPROFILE\Dropbox))
   {
    $SavePath = Test-Path $Env:USERPROFILE\Dropbox\ChocoPackagesBackup\$Env:ComputerName
	If ($SavePath -match "False")
	   {
	    New-Item $Env:USERPROFILE\Dropbox\ChocoPackagesBackup\$Env:ComputerName -Type Directory -force | out-null
	   }
    $ConfigFile = "$Env:USERPROFILE\Dropbox\ChocoPackagesBackup\$Env:ComputerName\packages.config"
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>" >$ConfigFile
    Write-Output "<packages>" >>$ConfigFile
	if ($UseVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }>>$ConfigFile
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" }>>$ConfigFile
		 }
    Write-Output "</packages>" >>$ConfigFile
	Write-Host "$ConfigFile SAVED!" -ForegroundColor green 
   }

# Backup Chocolatey package names on local computer to packages.config file in Google Drive
if ($UseGoogleDrive -match "True" -and (Test-Path "$Env:USERPROFILE\Google Drive"))
   {
    $SavePath = Test-Path "$Env:USERPROFILE\Google Drive\ChocoPackagesBackup\$Env:ComputerName"
	If ($SavePath -match "False")
	   {
	    New-Item "$Env:USERPROFILE\Google Drive\ChocoPackagesBackup\$Env:ComputerName" -Type Directory -force | out-null
	   }
    $ConfigFile = "$Env:USERPROFILE\Google Drive\ChocoPackagesBackup\$Env:ComputerName\packages.config"
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>" >$ConfigFile
    Write-Output "<packages>" >>$ConfigFile
	if ($UseVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }>>$ConfigFile
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" }>>$ConfigFile
		 }
    Write-Output "</packages>" >>$ConfigFile
	Write-Host "$ConfigFile SAVED!" -ForegroundColor green 
   }

# Backup Chocolatey package names on local computer to packages.config file on your HOMESHARE
if ($UseHomeShare -match "True" -and (Test-Path "$Env:HOMESHARE"))
   {
    $SavePath = Test-Path "$Env:HOMESHARE\ChocoPackagesBackup\$Env:ComputerName"
	If ($SavePath -match "False")
	   {
	    New-Item "$Env:HOMESHARE\ChocoPackagesBackup\$Env:ComputerName" -Type Directory -force | out-null
	   }
    $ConfigFile = "$Env:HOMESHARE\ChocoPackagesBackup\$Env:ComputerName\packages.config"
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>" >$ConfigFile
    Write-Output "<packages>" >>$ConfigFile
	if ($UseVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }>>$ConfigFile
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" }>>$ConfigFile
		 }
    Write-Output "</packages>" >>$ConfigFile
	Write-Host "$ConfigFile SAVED!" -ForegroundColor green 
   }   
   
# Backup Chocolatey package names on local computer to packages.config file in OneDrive   
if ($UseOneDrive -match "True" -and (Test-Path $Env:USERPROFILE\OneDrive))
   {
    $SavePath = Test-Path $Env:USERPROFILE\OneDrive\ChocoPackagesBackup\$Env:ComputerName
	If ($SavePath -match "False")
	   {
	    New-Item $Env:USERPROFILE\OneDrive\ChocoPackagesBackup\$Env:ComputerName -Type Directory -force | out-null
	   }   
    $ConfigFile = "$Env:USERPROFILE\OneDrive\ChocoPackagesBackup\$Env:ComputerName\packages.config"
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>" >$ConfigFile
    Write-Output "<packages>" >>$ConfigFile
	if ($UseVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }>>$ConfigFile
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" }>>$ConfigFile
		 }
    Write-Output "</packages>" >>$ConfigFile
	Write-Host "$ConfigFile SAVED!" -ForegroundColor green 
   }


# Backup Chocolatey package names on local computer to packages.config file in Netgear ReadyCLOUD   
if ($UseReadyCLOUD -match "True" -and (Test-Path $Env:USERPROFILE\ReadyCLOUD))
   {
    $SavePath = Test-Path $Env:USERPROFILE\ReadyCLOUD\ChocoPackagesBackup\$Env:ComputerName
	If ($SavePath -match "False")
	   {
	    New-Item $Env:USERPROFILE\ReadyCLOUD\ChocoPackagesBackup\$Env:ComputerName -Type Directory -force | out-null
	   }   
    $ConfigFile = "$Env:USERPROFILE\ReadyCLOUD\ChocoPackagesBackup\$Env:ComputerName\packages.config"
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>" >$ConfigFile
    Write-Output "<packages>" >>$ConfigFile
	if ($UseVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }>>$ConfigFile
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" }>>$ConfigFile
		 }
    Write-Output "</packages>" >>$ConfigFile
	Write-Host "$ConfigFile SAVED!" -ForegroundColor green 
   }


# Backup Chocolatey package names on local computer to packages.config file in TonidoSync
if ($UseTonidoSync -match "True" -and (Test-Path $Env:USERPROFILE\Documents\TonidoSync))
   {
    $SavePath = Test-Path $Env:USERPROFILE\Documents\TonidoSync\ChocoPackagesBackup\$Env:ComputerName
	If ($SavePath -match "False")
	   {
	    New-Item $Env:USERPROFILE\Documents\TonidoSync\ChocoPackagesBackup\$Env:ComputerName -Type Directory -force | out-null
	   }   
    $ConfigFile = "$Env:USERPROFILE\Documents\TonidoSync\ChocoPackagesBackup\$Env:ComputerName\packages.config"
    Write-Output "<?xml version=`"1.0`" encoding=`"utf-8`"?>" >$ConfigFile
    Write-Output "<packages>" >>$ConfigFile
	if ($UseVersions -match "True")
	   {
        choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" version=`"$($_.SubString($_.IndexOf("|") + 1))`" />" }>>$ConfigFile
	   } else {
         choco list -lo -r -y | % { "   <package id=`"$($_.SubString(0, $_.IndexOf("|")))`" />" }>>$ConfigFile
		 }
    Write-Output "</packages>" >>$ConfigFile
	Write-Host "$ConfigFile SAVED!" -ForegroundColor green 
   }
   
Write-Host "To reinstall your Chocolatey packages:" -ForegroundColor magenta 
Write-Host "Go to the saved packages.config location and type CINST PACKAGES.CONFIG -Y" -ForegroundColor magenta 







