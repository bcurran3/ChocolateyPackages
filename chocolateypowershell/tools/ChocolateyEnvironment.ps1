# SUGGESTION: Manually edit the ChocolateyPowerShell icon properties' Colors tab Selected Color Values to rgb(84,42,12) or rgb(160,85,45) for a unique Chocolatey brown background.

function global:CPSHelpersWeb {start 'https://chocolatey.org/docs/helpers-reference'}

function global:CPSHelp{
 Write-Host
 Write-Host 'Available Chocolatey related functions:' -ForeGround white
 Get-command -Module choco*
 Write-Host
 Write-Host 'Type ' -ForeGround white -NoNewLine
 Write-Host 'CPSHelpersWeb' -ForeGround magenta -NoNewLine
 Write-Host ' to open ' -ForeGround white -NoNewLine
 Write-Host 'https://chocolatey.org/docs/helpers-reference' -ForeGround darkmagenta -NoNewLine
 Write-Host ' in your browser.' -ForeGround white
}

Set-Location $env:ChocolateyInstall\helpers
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Import-Module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1
Set-Location $env:ChocolateyInstall\extensions\chocolatey-core
Import-Module $env:ChocolateyInstall\extensions\chocolatey-core\chocolatey-core.psm1
Set-Location $env:SystemDrive\
Write-Host 'Welcome to ChocolateyPowerShell! - Chocolatey functions and extensions are now loaded.' -ForeGround cyan
Write-Host 'Type ' -ForeGround white -NoNewLine
Write-Host 'CPSHelp' -ForeGround magenta -NoNewLine
Write-Host ' to see a list of available Chocolatey related functions.' -ForeGround white
Write-Host 'Type ' -ForeGround white -NoNewLine
Write-Host 'CPSHelpersWeb' -ForeGround magenta -NoNewLine
Write-Host ' to open ' -ForeGround white -NoNewLine
Write-Host 'https://chocolatey.org/docs/helpers-reference' -ForeGround darkmagenta -NoNewLine
Write-Host ' in your browser.' -ForeGround white
function global:prompt {"[ChocolateyPS] $($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "}
