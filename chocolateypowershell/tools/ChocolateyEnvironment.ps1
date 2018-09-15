Set-Location $env:ChocolateyInstall\helpers
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Import-Module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1
Set-Location $env:ChocolateyInstall\extensions\chocolatey-core
Import-Module $env:ChocolateyInstall\extensions\chocolatey-core\chocolatey-core.psm1
Set-Location $env:SystemDrive\
function global:Get-CPSHelp{get-childitem function:}
Write-Host "Welcome to ChocolateyPowerShell! - Chocolatey functions and extensions are now loaded." -foreground white
Write-Host 'Type Get-CPSHelp to see a list of available functions.' -foreground white
function global:prompt {"[ChocolateyPS] $($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "}
