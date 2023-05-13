# Requires -RunAsAdministrator
# choco-protocol-support.ps1 Copyleft 2017-2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

param(
     [Parameter()]
     [string]$chocoprotocolURL
 )
 
$version=$null
$parameters=$null
$arguments=$null

#$Host.UI.RawUI.BackgroundColor = 'DarkGreen'
#Clear-Host

$ErrorActionPreference = 'Stop'
Write-Host "choco-protocol-support.ps1 v0.0.2.0 (2023-05-11) - install Chocolatey packages from URLs" -Foreground White
Write-Host "Copyleft 2017-2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

if (!($chocoprotocolURL)){Write-Warning "choco URL not provided, nothing to do!"; return}

Write-Host "  ** Processing $chocoprotocolURL" -ForegroundColor Magenta

$chocoprotocolURL=$chocoprotocolURL.trimend('/')
$chocoprotocolURL=$chocoprotocolURL.replace('choco://','')
[array]$chocoprotocolURL=$chocoprotocolURL.split("/")
$packagename=($chocoprotocolURL[0])

for($num=0; $num -lt $chocoprotocolURL.count; $num++) {
	if ($chocoprotocolURL[$num] -match 'version=') {$version=($chocoprotocolURL[$num]); $version=$version.replace('version=','')}
	if ($chocoprotocolURL[$num] -match 'parameters=') {($parameters=$chocoprotocolURL[$num]); $parameters=$parameters.replace('parameters=','')}
	if ($chocoprotocolURL[$num] -match 'arguments=') {($arguments=$chocoprotocolURL[$num]); $arguments=$arguments.replace('arguments=','')}
    if ($chocoprotocolURL[$num] -match 'source=') {($source=$chocoprotocolURL[$num]); $source=$source.replace('source=','')}	
	}

Write-Host "  ** Installing Chocolatey PACKAGE NAME: $packagename" -NoNewline -ForegroundColor Magenta
if ($version){Write-Host " VERSION: $version" -NoNewline -Foreground Magenta}
if ($parameters){Write-Host " PARAMETERS: $parameters" -NoNewline -Foreground Magenta}
if ($arguments){Write-Host " ARGUMENTS: $arguments" -NoNewline -Foreground Magenta}
if ($source){Write-Host " SOURCE: $source" -NoNewline -Foreground Magenta}

#if (Test-Path $env:ChocolateyInstall\lib\gsudo\bin\gsudo.exe) {
#	gsudo -s $env:ChocolateyInstall\choco.exe install -y $packagename $version
#} else {
#	start-process sudo $env:ChocolateyInstall\choco.exe install -y  $packagename $version
#}

$command=$packagename
if ($version) {$command=$command + " --version=$version"}
Start-Process -Filepath "$env:ChocolateyInstall\choco.exe" -ArgumentList "install -y $command" -Wait -Verb RunAs

Write-Host "`n`nFound choco-protocol-support.ps1 useful?" -ForegroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
Start-Sleep -s 10

# TDL 
# error checking for malformed URLs
# add parameters, arguments, and source support
# MAYBE a config file that allows toggling of parameters, arguments, source, etc.
