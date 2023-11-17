#Requires -RunAsAdministrator
# $ErrorActionPreference = 'Stop'
# CCU.ps1 (Chocolatey Continuous Upgrader) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

param (
    [switch]$Foreground,
	[Alias("?")][switch]$Help,
	[switch]$DoNotNotify,
	[Alias("NotifyOnly")][switch]$OnlyNotify,
    [switch]$Start,
    [switch]$Stop,
    [switch]$Status,
	[int]$WaitTime
 )

# TODO: add another switch for minimum notifications;i.e. only blahblah is avaible for ugprade
# TODO: Figure out why Burnt Toast chokes sometimes and figure out how to fix it
# TODO: Figure out why PowerShell sometimes exits and temporarily crashes with:
# [error 2147942405 (0x80070005) when launching `%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe']

Write-Host "CCU.ps1 v0.1.0-alpha (2023/11/16) - (unofficial) Chocolatey Continuous Upgrader" -Foreground White
Write-Host "Copyleft 2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White


if (!$Start -and !$Stop -and !$Status -and !$Help -and !$OnlyNotify -and !$Foreground -and !$DoNotNotify ) {
	Write-Host "  ** Please run 'CCU -?' or 'CCU -help' for help menu.`n" -Foreground White
	return
}

if ( $Help ) {
	Write-Host "OPTIONS AND SWITCHES:" -Foreground Magenta
	Write-Host " -Start"
	Write-Host "    Start checking for and install upgrades."
	Write-Host " -Stop"
	Write-Host "    Stop checking for upgrades."
	Write-Host " -Status"
	Write-Host "    Show status of CCU background job."
	Write-Host " -DoNotNotify"
	Write-Host "    Don't send notifications about upgrades."
	Write-Host " -OnlyNotify"
	Write-Host "    Start checking for upgrades but do not install them."
	Write-Host " -Foreground"
    Write-Host "    Run in foreground instead of background."
	Write-Host " #"
	Write-Host "    Number of minutes to wait between checks (default 30)."
	Write-Host " -Help, -?"
	Write-Host "    This menu."
	Write-Host 
	Write-Host "EXAMPLE:" -Foreground Magenta
	Write-Host " CCU -Start 60`n"
	return
}

if ($Foreground) {$Start=$True;$env:Notify=$False} else {$env:Notify=$True}
if ($OnlyNotify){$Start=$True;$env:AutoUpgrade=$False;$env:Notify=$True} else {$env:AutoUpgrade=$True}
if ($DoNotNotify) {$Start=$True;$env:Notify=$False} else {$env:Notify=$True}
if (Get-Module -ListAvailable -Name BurntToast) {$env:ToastAvailable=$True} else {$env:ToastAvailable=$False}
if (!($ENV:ChocolateyToolsLocation)) {$ENV:ChocolateyToolsLocation = "$ENV:SystemDrive\tools"}
if (!$WaitTime) {$WaitTime="30"}
$env:WaitTime=$WaitTime
$toolsdir=(Split-Path -parent $MyInvocation.MyCommand.Definition)
$CheckJob=Get-Job | Where-Object {$_.Name -eq "CCU"}
$CheckForeground=Test-Path "$env:chocolateyToolsLocation\BCURRAN3\CCUprocesshandle.xml"

if ($Status){
	if ($CheckJob){
		Write-Host "  ** CCU is running in background!" -Foreground Yellow
		Receive-Job -Name CCU
		return
		} else {
			Write-Host "  ** CCU is not running in background." -Foreground Yellow
		}
	if ($CheckForeground){
	    Write-Host "  ** CCU is running in foreground!`n" -Foreground Yellow
	} else {
		Write-Host "  ** CCU is not running in foreground.`n" -Foreground Yellow
	}
	return
}

if ($Start) {
	if ($CheckJob){ 
	Write-Host "  ** CCU is already running in background!`n" -Foreground Yellow
	return
	}
	if ($CheckForeground){
		Write-Host "  ** CCU is already running in foreground!`n." -Foreground Yellow
		return
	}
	if ($Foreground){
		# TODO: fix ./CCU.psm to include full path (can't use variable as currently implemented) MAYBE OK using -WorkingDirectory
		$CCUProcess = Start-Process PowerShell -ArgumentList '$host.ui.RawUI.WindowTitle=''Chocolatey Continuous Updater''; Import-Module ./CCU.psm1; for (;;) {keep_checking}' -WindowStyle Normal -WorkingDirectory "$toolsDir" -PassThru
		$CCUProcess | Export-Clixml -Path "$env:chocolateyToolsLocation\BCURRAN3\CCUprocesshandle.xml"
		Write-Host "  ** CCU STARTED in foreground." -Foreground Yellow
		} else {
			Start-Job -Name CCU -InitializationScript { Import-Module S:\dev\GitHub\ChocolateyPackages\choco-continuous-upgrader\ccu.psm1 } {for (;;) {keep_checking}} | Out-Null
	 	    Write-Host "  ** CCU STARTED in background." -Foreground Yellow 
		}
		if (!($OnlyNotify)) {Write-Host "  ** CCU automatic upgrades ENABLED" -Foreground Yellow} else {Write-Host "  ** CCU automatic upgrades are DISABLED." -Foreground Yellow}
		if ($DoNotNotify) {Write-Host "  ** CCU notifications DISABLED." -Foreground Yellow}
		Write-Host "  ** CCU will check for upgrades every $WaitTime minutes.`n" -Foreground Yellow
		return
}

if ($Stop){
	if ($CheckJob){
		Stop-Job -Name CCU
	    Remove-Job -Name CCU
		Write-Host "  ** CCU STOPPED in background." -Foreground Yellow
		} else {
			Write-Host "  ** CCU not running in background." -Foreground Yellow
			}
	if ($CheckForeground)
	{
		$CCUProcess = Import-Clixml -Path "$env:chocolateyToolsLocation\BCURRAN3\CCUprocesshandle.xml"
        $CCUProcess | Stop-Process -ErrorAction SilentlyContinue
		if (!$?) {
			Write-Host "  ** CCU already STOPPED! (Someone closed the window?)`n" -Foreground Yellow
			} else {
				Write-Host "  ** CCU STOPPED in foreground.`n" -Foreground Yellow
			}
		Remove-Item "$env:chocolateyToolsLocation\BCURRAN3\CCUprocesshandle.xml"
	} else {
		Write-Host "  ** CCU not running in foreground.`n" -Foreground Yellow
	}
	return
}

Write-Host "`nFound CCU.ps1 useful?" -ForegroundColor White
Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
Start-Sleep -s 10
