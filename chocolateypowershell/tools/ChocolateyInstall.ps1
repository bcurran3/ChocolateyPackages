# ChocolateyPowerShell v0.0.2.3 (01-30-2021) Copyleft 2018-2021 by Bill Curran AKA BCURRAN3
$ErrorActionPreference = 'Stop'
$packageName  = 'chocolateypowershell' 
$shortcutName = 'ChocolateyPowerShell.lnk'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe          = "$ENV:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" "$toolsDir\chocolateypowershell.ico" -RunAsAdmin

if (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
    Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" -IconLocation "$toolsDir\chocolateypowershell.ico" -RunAsAdmin
   } else {
     Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" -IconLocation "$toolsDir\chocolateypowershell.ico" -RunAsAdmin
    }
