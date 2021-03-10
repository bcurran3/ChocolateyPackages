$ErrorActionPreference = 'Stop'
#Requires -RunAsAdministrator
# choco-upgrade-all.ps1 Copyleft 2021 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

Write-Host "choco-upgrade-all.ps1 v0.0.6-pre (03/10/2021) - Upgrade your Chocolatey packages with extras" -Foreground White
Write-Host "Copyleft 2021 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

# Import preferences from choco-upgrade-all.config
[xml]$ConfigFile = Get-Content "$ENV:ChocolateyToolsLocation\BCURRAN3\choco-upgrade-all.config"
$DeleteNewDesktopIcons   = $ConfigFile.Settings.Preferences.DeleteNewDesktopIcons
$DeleteNewStartMenuIcons = $ConfigFile.Settings.Preferences.DeleteNewStartMenuIcons
$PreProcessScript        = $ConfigFile.Settings.Preferences.PreProcessScript
$PostProcessScript       = $ConfigFile.Settings.Preferences.PostProcessScript

# Run pre-processor if configured
if ($PreProcessScript){&$PreProcessScript}

# get existing Desktop and Start Menu icons
$UserDesktopIconsPre = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk" -Recurse
$PublicDesktopIconsPre = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk" -Recurse
$UserStartMenuIconsPre = Get-ChildItem -Path "$env:AppData\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse
$PublicStartMenuIconsPre = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse

&choco upgrade all -y

# get existing and new Desktop and Start Menu icons
$UserDesktopIconsPost = Get-ChildItem -Path "$env:AppData\*.lnk" -Recurse
$PublicDesktopIconsPost = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk" -Recurse
$UserStartMenuIconsPost = Get-ChildItem -Path "$env:AppData\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse
$PublicStartMenuIconsPost = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse

# Delete the new icons if configured to do so (opt in only)
if ($DeleteNewDesktopIcons -eq 'True'){
   $IconsNew = Compare-Object -ReferenceObject ($UserDesktopIconsPre) -DifferenceObject ($UserDesktopIconsPost) -PassThru
   del $IconsNew.fullname # <--- This needs to be fixed
   $IconsNew = Compare-Object -ReferenceObject ($PublicDesktopIconsPre) -DifferenceObject ($PublicDesktopIconsPost) -PassThru
   del $IconsNew.fullname # <--- This needs to be fixed
   }
if ($DeleteNewStartMenuIcons -eq 'True'){
   $IconsNew = Compare-Object -ReferenceObject ($UserStartMenuIconsPre) -DifferenceObject ($UserStartMenuIconsPost) -PassThru
   del $IconsNew.fullname # <--- This needs to be fixed
   $IconsNew = Compare-Object -ReferenceObject ($PublicStartMenuIconsPre) -DifferenceObject ($PublicStartMenuIconsPost) -PassThru
   del $IconsNew.fullname # <--- This needs to be fixed
   }

# Run post-processor if configured
if ($PostProcessScript){&$PostProcessScript}