# Requires -RunAsAdministrator
# choco-protocol-support.ps1 Copyleft 2017-2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

param(
     [Parameter()]
     [string]$chocoprotocolURL,

     [Parameter()]
     [string]$version
 )

$ErrorActionPreference = 'Stop'
Write-Host "choco-protocol-support.ps1 v0.0.2.0 (2023-05-11) - install Chocolatey packages from URLs" -Foreground White
Write-Host "Copyleft 2017-2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

if (!($chocoprotocolURL)){Write-Warning "choco URL not provided, nothing to do!"; return}
$package=$chocoprotocolURL.replace('choco://','')
$package=$package.replace('/','')
$version=$version.replace(' ','')
if ($version -notmatch '--version=') {$version=$null}

Write-Host "  ** Installing Chocolatey PACKAGE: $package"  -NoNewline -ForegroundColor Magenta
if ($version){Write-Host " VERSION: $($version.replace('--version=',''))" -Foreground Magenta}
Write-Host "`n"

#if (Test-Path $env:ChocolateyInstall\lib\gsudo\bin\gsudo.exe) {
#	gsudo -s $env:ChocolateyInstall\choco.exe install -y $package $version
#} else {
#	start-process sudo $env:ChocolateyInstall\choco.exe install -y  $package $version
#}

start-process -Filepath "$env:ChocolateyInstall\choco.exe" -ArgumentList "install -y $package $version" -Wait -Verb RunAs

Write-Host "`nFound choco-protocol-support.ps1 useful?" -ForegroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
Start-Sleep -s 10

