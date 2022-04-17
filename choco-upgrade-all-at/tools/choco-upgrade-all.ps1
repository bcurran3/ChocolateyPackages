$ErrorActionPreference = 'Stop'
#Requires -RunAsAdministrator
# choco-upgrade-all.ps1 Copyleft 2022 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

Write-Host "Choco-Upgrade-All.ps1 (02/11/2022) - Upgrade your Chocolatey packages with enhanced options" -Foreground White
Write-Host "Copyleft 2022 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

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

if (Test-Path $env:ChocolateyInstall\bin\notepad++.exe){
     $Editor="notepad++.exe"
    } else {
      $Editor="notepad.exe"
    }

if ($args -eq "-EditConfig") {
    Write-Host "  ** Editing contents of choco-upgrade-all.config." -Foreground Magenta
	&$Editor "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.config"
	return
}

# Minor logging
if (Test-Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"){
   $LogSize=(Get-ChildItem -Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log").length
   if ($LogSize -gt 51200) {
	   Remove-Item "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
	   Write-Output "$(Get-Date) Choco-Upgrade-All Deleted log file" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
	  }
  }
if ($DebugLogging -eq 'True'){
	Start-Transcript -Path $env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log -Append
   } else {
     Write-Output "$(Get-Date) Choco-Upgrade-All STARTED" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
   }

# Run pre-processor if configured
if ($PreProcessScript){&$PreProcessScript}

# When running as SYSTEM (scheduled task) use the $DefaultUserProfile as the default user profile if defined
if ($DefaultUserProfile) {
	$env:USERPROFILE="$env:SystemDrive\Users\$DefaultUserProfile"
	$env:APPDATA="$env:SystemDrive\Users\$DefaultUserProfile\AppData\Roaming"
	}

# get existing Desktop and Start Menu icons
if (Test-Path "$env:USERPROFILE\Desktop") {$UserDesktopIconsPre = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk"}
if (Test-Path "$env:PUBLIC\Desktop") {$PublicDesktopIconsPre = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk"}
if (Test-Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs") {$UserStartMenuIconsPre = Get-ChildItem -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse}
if (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu") {$PublicStartMenuIconsPre = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse}

# Do the Chocolatey Humpty Hump
Start-Process -NoNewWindow -FilePath "$env:ChocolateyInstall\bin\choco.exe" -ArgumentList "upgrade all -y $ConfigArguments $args" -Wait

# Get existing and new Desktop and Start Menu icons
if (Test-Path "$env:USERPROFILE\Desktop") {$UserDesktopIconsPost = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk"}
if (Test-Path "$env:PUBLIC\Desktop")  {$PublicDesktopIconsPost = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk"}
if (Test-Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs") {$UserStartMenuIconsPost = Get-ChildItem -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse}
if (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu") {$PublicStartMenuIconsPost = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse}

# Delete new Desktop icons if configured to do so
if ($DeleteNewDesktopIcons -eq 'True'){
	if ($UserDesktopIconsPre.count -ne '0' -and $UserDesktopIconsPost.count -ne '0'){
       $IconsNew = Compare-Object -ReferenceObject ($UserDesktopIconsPre) -DifferenceObject ($UserDesktopIconsPost) -PassThru
       if ($IconsNew -ne $null) { del $IconsNew.fullname }
	   }
	if ($PublicDesktopIconsPre.count -ne '0' -and $PublicDesktopIconsPost.count -ne '0'){
       $IconsNew = Compare-Object -ReferenceObject ($PublicDesktopIconsPre) -DifferenceObject ($PublicDesktopIconsPost) -PassThru
       if ($IconsNew -ne $null) { del $IconsNew.fullname }
       }
  }
# Delete new Start Menu icons if configured to do so
if ($DeleteNewStartMenuIcons -eq 'True'){
	if ($UserStartMenuIconsPre.count -ne '0' -and $UserStartMenuIconsPost.count -ne '0'){
       $IconsNew = Compare-Object -ReferenceObject ($UserStartMenuIconsPre) -DifferenceObject ($UserStartMenuIconsPost) -PassThru
       if ($IconsNew -ne $null) { del $IconsNew.fullname }
	   }
	if ($PublicStartMenuIconsPre.count -ne '0' -and $PublicStartMenuIconsPost.count -ne '0'){
       $IconsNew = Compare-Object -ReferenceObject ($PublicStartMenuIconsPre) -DifferenceObject ($PublicStartMenuIconsPost) -PassThru
       if ($IconsNew -ne $null) { del $IconsNew.fullname }
       }
  }

# Run post-processor if configured
if ($PostProcessScript){&$PostProcessScript}

Write-Host "Found Choco-Upgrade-All.ps1 useful?" -ForegroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
if ($DebugLogging -eq 'True'){
    Stop-Transcript
   } else {
# Minor logging
	 Write-Output "$(Get-Date) Choco-Upgrade-All FINISHED" >> "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.log"
   }
