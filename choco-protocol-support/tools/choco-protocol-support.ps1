# choco-protocol-support.ps1 Copyleft 2017-2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Suggestions? Problems? Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues

param(
     [Parameter()]
     [string]$chocoprotocolURL
 )
 
$chocopackageoptions=$null
$installarguments=$null
$params=$null
$upgrade=$false
$version=$null

$ErrorActionPreference = 'Continue'
Write-Host "Choco-Protocol-Support.ps1 v0.2 (2023-05-17) - install Chocolatey packages from URLs" -Foreground White
Write-Host "Copyleft 2017-2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

if (!($chocoprotocolURL)){Write-Warning "choco URL not provided, nothing to do!"; return}

Write-Host "  ** Processing $chocoprotocolURL" -ForegroundColor Magenta

$chocoprotocolURL=$chocoprotocolURL.trimend('/')
$chocoprotocolURL=$chocoprotocolURL.replace('choco://','')
[array]$chocoprotocolURL=$chocoprotocolURL.split("/")
$packagename=($chocoprotocolURL[0])

for($num=0; $num -lt $chocoprotocolURL.count; $num++) {
	if ($chocoprotocolURL[$num] -match 'version=') {$version=($chocoprotocolURL[$num]); $version=$version.replace('version=','')}
	if ($chocoprotocolURL[$num] -match 'v=') {$version=($chocoprotocolURL[$num]); $version=$version.replace('v=','')}
	if ($chocoprotocolURL[$num] -match 'params=') {($params=$chocoprotocolURL[$num]); $params=$params.replace('params=','')}
	if ($chocoprotocolURL[$num] -match 'installarguments=') {($installarguments=$chocoprotocolURL[$num]); $installarguments=$installarguments.replace('arguments=','')}
    if ($chocoprotocolURL[$num] -match 'source=') {($source=$chocoprotocolURL[$num]); $source=$source.replace('source=','')}
	}
	
if (Test-Path $env:ChocolateyInstall\lib\$packagename\$packagename.nuspec) {
	[xml]$nuspecFile = Get-Content "$env:ChocolateyInstall\lib\$packagename\$packagename.nuspec"
	$OldVersion = $nuspecFile.package.metadata.version
	$upgrade=$true
}

if (!$upgrade) {
	Write-Host "  ** INSTALLING $packagename" -NoNewline -ForegroundColor Magenta
	if ($version){Write-Host " v$version" -NoNewline -Foreground Magenta}
} else {
	Write-Host "  ** UPGRADING $packagename" -NoNewline -ForegroundColor Magenta
	if ($version){Write-Host " v$OldVersion to v$version" -NoNewline -Foreground Magenta}
}
if ($params){Write-Host " params: $params" -NoNewline -Foreground Magenta}
if ($installarguments){Write-Host " install arguments: $installarguments" -NoNewline -Foreground Magenta}
if ($source){Write-Host " source: $source" -NoNewline -Foreground Magenta}

if (!$upgrade) {$chocopackagecommand='install'} else {$chocopackagecommand='upgrade'}
if ($version) {$chocopackageoptions=$chocopackageoptions + " --version=$version"}

Start-Process -Filepath "$env:ChocolateyInstall\choco.exe" -ArgumentList "$chocopackagecommand -y $packagename $chocopackageoptions" -Wait -Verb RunAs

Write-Host "`n`nFound choco-protocol-support.ps1 useful?" -ForegroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
Start-Sleep -s 5

# TDL 
# error checking for malformed URLs
# add parameters, install arguments, and source support (Going to need a LOT of difficult parsing!)
# MAYBE a config file that allows toggling of parameters, install arguments, source, etc. 
# Theoretically possible to add all choco install options and switches, but why?

