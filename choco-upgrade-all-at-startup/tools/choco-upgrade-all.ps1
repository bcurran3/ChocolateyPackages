$ErrorActionPreference = 'Stop'
#Requires -RunAsAdministrator
# choco-upgrade-all.ps1 Copyleft 2021-2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

Write-Host "Choco-Upgrade-All.ps1 v0.0.7 (2023/05/15) - Upgrade your Chocolatey packages with enhanced options" -Foreground White
Write-Host "Copyleft 2021-2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

# Verify ChocolateyToolsLocation was created by Get-ToolsLocation during install and is in the environment
if (!($env:ChocolateyToolsLocation)) {$env:ChocolateyToolsLocation = "$env:SystemDrive\tools"}
if (!(Test-Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.config")) {Write-Warning "Configuration not found. Please re-install.";throw}

# Import preferences from choco-upgrade-all.config
[xml]$ConfigFile = Get-Content "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.config"
$ConfigArguments         = $ConfigFile.Settings.Preferences.ConfigArguments
$DebugLogging            = $ConfigFile.Settings.Preferences.DebugLogging
$DefaultUserProfile      = $ConfigFile.Settings.Preferences.DefaultUserProfile
$DeleteNewDesktopIcons   = $ConfigFile.Settings.Preferences.DeleteNewDesktopIcons
$DeleteNewStartMenuIcons = $ConfigFile.Settings.Preferences.DeleteNewStartMenuIcons
#$StopCUAAfter            = $ConfigFile.Settings.Preferences.StopCUAAfter            # Not implemented yet
$PreProcessScript        = $ConfigFile.Settings.Preferences.PreProcessScript
$PostProcessScript       = $ConfigFile.Settings.Preferences.PostProcessScript

$IconsDeleted=0

# Set Notepad++ as preferred editor/viewer
if (Test-Path $env:ChocolateyInstall\bin\notepad++.exe){
     $Editor="notepad++.exe"
    } else {
      $Editor="notepad.exe"
    }

# Easily edit the config file
if ($args -eq "-EditConfig") {
    Write-Host "  ** Editing contents of choco-upgrade-all.config." -Foreground Magenta
	&$Editor "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.config"
	return
}

# Easily view the log file
if ($args -eq "-ViewLog") {
    Write-Host "  ** Viewing contents of choco-upgrade-all.log." -Foreground Magenta
	&$Editor "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
	return
}

# Logging - always logging
if (Test-Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"){
   $LogSize=(Get-ChildItem -Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log").length
   if ($LogSize -gt 40960) {
	   Remove-Item "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
	   Write-Output "$(Get-Date) Choco-Upgrade-All Deleted log file" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
	  }
  }
Write-Output "----------------------------------------------------------------------" >> "$ENV:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
Write-Output "$(Get-Date) Choco-Upgrade-All STARTED" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"


# add to log file
function Add2Log {
    Param ( [string]$comment )

    Write-Output "$(Get-Date) [INFO ] $comment" >> "$ENV:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
}

if ($DebugLogging){
	Add2Log "CONFIG: DebugLogging is set to $DebugLogging. (ignored)"
} else {
		Add2Log "CONFIG: DebugLogging is not set. (ignored)"
}

# Run pre-processor if configured
if ($PreProcessScript){
	&$PreProcessScript
	Add2Log "EXECUTED: $PreProcessScript"
	}

# When running as SYSTEM (scheduled task) use the $DefaultUserProfile as the default user profile if defined
if ($DefaultUserProfile) {
	$env:USERPROFILE="$env:SystemDrive\Users\$DefaultUserProfile"
	$env:APPDATA="$env:SystemDrive\Users\$DefaultUserProfile\AppData\Roaming"
	Add2Log "CONFIG: DefaultUserProfile is set to $DefaultUserProfile"
} else {
		Add2Log "CONFIG: DefaultUserProfile is not set."
}


if ($ConfigArguments) {
    Add2Log "CONFIG: ConfigArguments are set to $ConfigArguments"
} else {
	Add2Log "CONFIG: ConfigArguments are not set."
}

# get existing Desktop and Start Menu icons
if (Test-Path "$env:USERPROFILE\Desktop") {$UserDesktopIconsPre = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk"}
if ($UserDesktopIconsPre -eq $null) {$UserDesktopIconsPre=0}
if (Test-Path "$env:PUBLIC\Desktop") {$PublicDesktopIconsPre = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk"}
if ($PublicDesktopIconsPre -eq $null) {$PublicDesktopIconsPre=0}
if (Test-Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs") {$UserStartMenuIconsPre = Get-ChildItem -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse}
if ($UserStartMenuIconsPre -eq $null) {$UserStartMenuIconsPre=0}
if (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu") {$PublicStartMenuIconsPre = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse}
if ($PublicStartMenuIconsPre -eq $null) {$PublicStartMenuIconsPre=0}

# Do the Chocolatey Humpty Hump
Start-Process -NoNewWindow -FilePath "$env:ChocolateyInstall\bin\choco.exe" -ArgumentList "upgrade all -y $ConfigArguments $args" -Wait

# Get existing and new Desktop and Start Menu icons
if (Test-Path "$env:USERPROFILE\Desktop") {$UserDesktopIconsPost = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk"}
if ($UserDesktopIconsPost -eq $null) {$UserDesktopIconsPost=0}
if (Test-Path "$env:PUBLIC\Desktop")  {$PublicDesktopIconsPost = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk"}
if ($PublicDesktopIconsPost -eq $null) {$PublicDesktopIconsPost=0}
if (Test-Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs") {$UserStartMenuIconsPost = Get-ChildItem -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse}
if ($UserStartMenuIconsPost -eq $null) {$UserStartMenuIconsPost=0}
if (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu") {$PublicStartMenuIconsPost = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse}
if ($PublicStartMenuIconsPost -eq $null) {$PublicStartMenuIconsPost=0}

# Delete new Desktop icons if configured to do so
if ($DeleteNewDesktopIcons -eq 'True'){
	Add2Log "CONFIG: DeleteNewDesktopIcons is set to TRUE"
	if ($UserDesktopIconsPre.count -ne '0' -and $UserDesktopIconsPost.count -ne '0'){
       $IconsNew = Compare-Object -ReferenceObject ($UserDesktopIconsPre) -DifferenceObject ($UserDesktopIconsPost) -PassThru
       if ($IconsNew -ne $null) {
		   Remove-Item $IconsNew.fullname
		   $IconsDeleted=$IconsDeleted + $IconsNew.count
	       $IconsNew | % {Add2Log "DELETED: $_"}
	    }
	}
	if ($PublicDesktopIconsPre.count -ne '0' -and $PublicDesktopIconsPost.count -ne '0'){
       $IconsNew = Compare-Object -ReferenceObject ($PublicDesktopIconsPre) -DifferenceObject ($PublicDesktopIconsPost) -PassThru
       if ($IconsNew -ne $null) {
		   Remove-Item $IconsNew.fullname
		   $IconsDeleted=$IconsDeleted + $IconsNew.count
	       $IconsNew | % {Add2Log "DELETED: $_"}
	    }
    }
} else {
	Add2Log "CONFIG: DeleteNewDesktopIcons is set to FALSE"
}

# Delete new Start Menu icons if configured to do so
if ($DeleteNewStartMenuIcons -eq 'True'){
	Add2Log "CONFIG: DeleteNewStartMenuIcons is set to TRUE"
	if ($UserStartMenuIconsPre.count -ne '0' -and $UserStartMenuIconsPost.count -ne '0'){
       $IconsNew = Compare-Object -ReferenceObject ($UserStartMenuIconsPre) -DifferenceObject ($UserStartMenuIconsPost) -PassThru
       if ($IconsNew -ne $null) {
		   Remove-Item $IconsNew.fullname
		   $IconsDeleted=$IconsDeleted + $IconsNew.count
	       $IconsNew | % {Add2Log "DELETED: $_"}
	    }
    }
	if ($PublicStartMenuIconsPre.count -ne '0' -and $PublicStartMenuIconsPost.count -ne '0'){
       $IconsNew = Compare-Object -ReferenceObject ($PublicStartMenuIconsPre) -DifferenceObject ($PublicStartMenuIconsPost) -PassThru
       if ($IconsNew -ne $null) {
		   Remove-Item $IconsNew.fullname
		   $IconsDeleted=$IconsDeleted + $IconsNew.count
	       $IconsNew | % {Add2Log "DELETED: $_"}
	    }
    }
} else {
	Add2Log "CONFIG: DeleteNewStartMenuIcons is set to FALSE"
}

# Run post-processor if configured
if ($PostProcessScript){
	&$PostProcessScript
	Add2Log "EXECUTED: $PostProcessScript"
	}

if (($DeleteNewDesktopIcons -eq 'True') -or ($DeleteNewStartMenuIcons -eq 'True')){
    Add2Log "DELETED $IconsDeleted unwanted shortcut(s)."
    Write-Host "`n  ** Choco-Upgrade-All DELETED $IconsDeleted unwanted shortcut(s).`n" -ForegroundColor Magenta
}

Write-Host "Found Choco-Upgrade-All.ps1 useful?" -ForegroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
Write-Output "$(Get-Date) Choco-Upgrade-All FINISHED" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
