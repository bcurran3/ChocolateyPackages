$packageName  = 'chocolateypowershell' 
$shortcutName = 'ChocolateyPowerShell.lnk'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe          = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

if (!(Test-Path "$env:ChocolateyInstall\choco.ico")){Invoke-WebRequest -Uri "https://cdn.rawgit.com/chocolatey/ChocolateyGUI/develop/Source/ChocolateyGui/chocolateyicon.ico" -OutFile "$env:ChocolateyInstall\choco.ico"}

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath $exe -Arguments "-noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -IconLocation "$env:ChocolateyInstall\choco.ico" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -Arguments "-noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -IconLocation "$env:ChocolateyInstall\choco.ico" -RunAsAdmin
