#Requires -RunAsAdministrator
# $ErrorActionPreference = 'Stop'
# CCU.ps1 (Chocolatey Continuous Upgrader) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

param (
    [switch]$Foreground,
    [switch]$Help,
	[Alias("NotifyOnly")][switch]$OnlyNotify,
    [switch]$Start,
    [switch]$Stop,
    [switch]$Status,
	[int]$WaitTime
 )

Write-Host "CCU.ps1 v0.1.0-alpha (2023/11/15) - (unofficial) Chocolatey Continuous Upgrader" -Foreground White
Write-Host "Copyleft 2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

$global:Notify=$True #DEBUG
$global:WaitTime=$WaitTime
if ($OnlyNotify){$global:AutoUpgrade=$False} else {$global:AutoUpgrade=$True}
if (Get-Module -ListAvailable -Name BurntToast) {$global:ToastAvailable=$True} else {$global:ToastAvailable=$False}

$CheckJob=Get-Job | Where-Object {$_.Name -eq "CCU"}

if ($Status){
	Receive-Job -Name CCU
	return
}

if ($Start -or $OnlyNotify) {
	if ($CheckJob){ 
	Write-Host "  ** CCU already running!" -Foreground Yellow
	return
	}
	if ($Foreground){
		Import-Module ./CCU.psm1
		Write-Host "  ** Control-C to stop." -Foreground Yellow
		for (;;) {keep_checking}
		return
		} else {
			Start-Job -Name CCU -InitializationScript { Import-Module S:\dev\GitHub\ChocolateyPackages\choco-continuous-upgrader\ccu.psm1 } {for (;;) {keep_checking}} | Out-Null
			Write-Host "  ** Started CCU background job" -Foreground Yellow
		}
		return
}

if ($Stop){
	if ($CheckJob){
		Stop-Job -Name CCU
	    Remove-Job -Name CCU
		Write-Host "  ** STOPPED CCU background job." -Foreground Yellow
		} else {
			Write-Host "  ** CCU background job not running." -Foreground Yellow
			}
	return
}

if ($CheckJob){Write-Host "  ** CCU is running!`n" -Foreground Yellow}

if ( $Help ) {
	Write-Host "OPTIONS AND SWITCHES:" -Foreground Magenta
	Write-Host " -Start"
	Write-Host "    Start checking for and install upgrades."
	Write-Host " -Stop"
	Write-Host "    Stop checking for upgrades."
	Write-Host " -Status"
	Write-Host "    Show status of CCU background job."
	Write-Host " -OnlyNotify"
	Write-Host "    Start checking for upgrades but do not install them."
	Write-Host " -Foreground"
    Write-Host "    Run in foreground instead of background."
	Write-Host " #"
	Write-Host "    Number of minutes to wait between checks (default 30)"
	Write-Host 
	Write-Host "EXAMPLE:" -Foreground Magenta
	Write-Host " CCU -Start 60`n"
	Write-Host 
}

if (!$args) {Write-Host "  ** CCU -Help for options and switches" -Foreground White}
