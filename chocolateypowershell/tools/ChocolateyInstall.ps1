$packageName  = 'chocolateypowershell' 
$shortcutName = 'ChocolateyPowerShell.lnk'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe          = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

if (!(Test-Path "$env:ChocolateyInstall\choco.ico")){Invoke-WebRequest -Uri "https://cdn.rawgit.com/chocolatey/ChocolateyGUI/develop/Source/ChocolateyGui/chocolateyicon.ico" -OutFile "$env:ChocolateyInstall\choco.ico"}

Write-Host "*** PSA: To avoid confusion with your normal PowerShell program icon, you may wish to manually change the icon for ChocolateyPowerShell to $env:ChocolateyInstall\choco.ico. Unfortunately this script is not allowed to automatically perform that function as this package is an independent 3rd party package not made by nor endorsed by the Chocolatey team. So please keep in mind this package is brought to you compliments of BCURRAN3 and NOT the Chocolatey Team. ***" -foreground magenta

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath $exe -Arguments "-noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -Arguments "-noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -RunAsAdmin
