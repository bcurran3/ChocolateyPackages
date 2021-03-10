$ErrorActionPreference = 'Stop'
#Requires -RunAsAdministrator
# choco-install.ps1 Copyleft 2021 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

Write-Host "choco-install.ps1 v0.0.6-pre (03/10/2021) - Install Chocolatey packages with extras" -Foreground White
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
$UserDesktopIconsPre     = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk"
$PublicDesktopIconsPre   = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk"
$UserStartMenuIconsPre   = Get-ChildItem -Path "$env:AppData\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse
$PublicStartMenuIconsPre = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse

&choco install $args

# get existing and new Desktop and Start Menu icons
$UserDesktopIconsPost     = Get-ChildItem -Path "$env:USERPROFILE\Desktop\*.lnk"
$PublicDesktopIconsPost   = Get-ChildItem -Path "$env:PUBLIC\Desktop\*.lnk"
$UserStartMenuIconsPost   = Get-ChildItem -Path "$env:AppData\Microsoft\Windows\Start Menu\Programs\*.lnk" -Recurse
$PublicStartMenuIconsPost = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\*.lnk" -Recurse

# Delete new Desktop icons if configured to do so
if ($DeleteNewDesktopIcons -eq 'True'){
   $IconsNew = Compare-Object -ReferenceObject ($UserDesktopIconsPre) -DifferenceObject ($UserDesktopIconsPost) -PassThru
   if ($IconsNew -ne $null) { del $IconsNew.fullname }
   $IconsNew = Compare-Object -ReferenceObject ($PublicDesktopIconsPre) -DifferenceObject ($PublicDesktopIconsPost) -PassThru
   if ($IconsNew -ne $null) { del $IconsNew.fullname }
   }
# Delete new Start Menu icons if configured to do so
if ($DeleteNewStartMenuIcons -eq 'True'){
   $IconsNew = Compare-Object -ReferenceObject ($UserStartMenuIconsPre) -DifferenceObject ($UserStartMenuIconsPost) -PassThru
   if ($IconsNew -ne $null) { del $IconsNew.fullname }
   $IconsNew = Compare-Object -ReferenceObject ($PublicStartMenuIconsPre) -DifferenceObject ($PublicStartMenuIconsPost) -PassThru
   if ($IconsNew -ne $null) { del $IconsNew.fullname }
   }

# Run post-processor if configured
if ($PostProcessScript){&$PostProcessScript}
