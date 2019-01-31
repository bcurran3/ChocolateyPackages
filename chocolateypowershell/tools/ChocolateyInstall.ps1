$ErrorActionPreference = 'Stop'
$packageName  = 'chocolateypowershell' 
$shortcutName = 'ChocolateyPowerShell.lnk'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe          = "$ENV:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" -RunAsAdmin

if (Test-Path "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
    Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" -RunAsAdmin
   } else {
     Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$ENV:SystemDrive\" -RunAsAdmin
    }
