$packageName  = 'chocolateypowershell' 
$shortcutName = 'ChocolateyPowerShell.lnk'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe          = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -RunAsAdmin

if (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -RunAsAdmin
   } else {
     Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -noexit -c $toolsDir\chocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -RunAsAdmin
    }