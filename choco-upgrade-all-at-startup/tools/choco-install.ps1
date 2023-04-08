﻿$ErrorActionPreference = 'Stop'
#Requires -RunAsAdministrator
# choco-install.ps1 Copyleft 2021 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

Write-Host "Choco-Install.ps1 (03/15/2021) - Install Chocolatey packages with enhanced options" -Foreground White
Write-Host "Copyleft 2021 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

# Verify ChocolateyToolsLocation was created by Get-ToolsLocation during install and is in the environment
if (!($env:ChocolateyToolsLocation)) {$env:ChocolateyToolsLocation = "$env:SystemDrive\tools"}
if (!(Test-Path "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.config")) {Write-Warning "Configuration not found. Please re-install.";throw}

# Import preferences from choco-upgrade-all.config
[xml]$ConfigFile = Get-Content "$env:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.config"
$ConfigArguments         = $ConfigFile.Settings.Preferences.ConfigArguments
$DebugLogging            = $ConfigFile.Settings.Preferences.DebugLogging
$DeleteNewDesktopIcons   = $ConfigFile.Settings.Preferences.DeleteNewDesktopIcons
$DeleteNewStartMenuIcons = $ConfigFile.Settings.Preferences.DeleteNewStartMenuIcons
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

# Run pre-processor if configured
if ($PreProcessScript){&$PreProcessScript}

# get existing Desktop and Start Menu icons
$UserDesktopIconsPre     = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk"
$PublicDesktopIconsPre   = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk"
$UserStartMenuIconsPre   = Get-ChildItem -Path "$env:AppData\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse
$PublicStartMenuIconsPre = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse

# Do the Chocolatey Humpty Hump
Start-Process -NoNewWindow -FilePath "$env:ChocolateyInstall\bin\choco.exe" -ArgumentList "install -y $ConfigArguments $args" -Wait

# get existing and new Desktop and Start Menu icons
$UserDesktopIconsPost     = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk"
$PublicDesktopIconsPost   = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk"
$UserStartMenuIconsPost   = Get-ChildItem -Path "$env:AppData\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse
$PublicStartMenuIconsPost = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse

# Delete new Desktop icons if configured to do so
if ($DeleteNewDesktopIcons -eq 'True'){
   $IconsNew = Compare-Object -ReferenceObject ($UserDesktopIconsPre) -DifferenceObject ($UserDesktopIconsPost) -PassThru
   if ($null -ne $IconsNew) { Remove-Item $IconsNew.fullname }
   $IconsNew = Compare-Object -ReferenceObject ($PublicDesktopIconsPre) -DifferenceObject ($PublicDesktopIconsPost) -PassThru
   if ($null -ne $IconsNew) { Remove-Item $IconsNew.fullname }
   }
# Delete new Start Menu icons if configured to do so
if ($DeleteNewStartMenuIcons -eq 'True'){
   $IconsNew = Compare-Object -ReferenceObject ($UserStartMenuIconsPre) -DifferenceObject ($UserStartMenuIconsPost) -PassThru
   if ($null -ne $IconsNew) { Remove-Item $IconsNew.fullname }
   $IconsNew = Compare-Object -ReferenceObject ($PublicStartMenuIconsPre) -DifferenceObject ($PublicStartMenuIconsPost) -PassThru
   if ($null -ne $IconsNew) { Remove-Item $IconsNew.fullname }
   }

# Run post-processor if configured
if ($PostProcessScript){&$PostProcessScript}

Write-Host "Found Choco-Install.ps1 useful?" -ForegroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
