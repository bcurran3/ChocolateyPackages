# ChocolateyPowerShell v0.0.2.2 (09-18-2020) Copyleft 2018-2020 by Bill Curran AKA BCURRAN3
$ErrorActionPreference = 'Stop'
$packageName  = 'chocolateypowershell' 
$shortcutName = 'ChocolateyPowerShell.lnk'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe          = "$ENV:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

if (!(Test-Path "$env:ChocolateyInstall\choco.ico")){Invoke-WebRequest -Uri "https://cdn.rawgit.com/chocolatey/ChocolateyGUI/develop/Source/ChocolateyGui/chocolateyicon.ico" -OutFile "$env:ChocolateyInstall\choco.ico"}

Write-Host "`n*** PSA: To avoid confusion with your normal PowerShell program icon, you may wish to manually change the icon`n         for ChocolateyPowerShell to $env:ChocolateyInstall\choco.ico. Unfortunately this script is not allowed to`n         automatically perform that function as this package is an independent 3rd party package not made by nor`n         endorsed by the Chocolatey team. So please keep in mind this package is brought to you compliments of BCURRAN3`n         and NOT the Chocolatey Team.`n" -Foreground Magenta

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" -RunAsAdmin

if (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
    Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" -RunAsAdmin
   } else {
     Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" -RunAsAdmin
    }
