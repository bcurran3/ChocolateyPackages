#Requires -RunAsAdministrator
# $ErrorActionPreference = 'Stop'
# CCU.ps1 (Chocolatey Continuous Upgrader) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

param (
	[Alias("?")][switch]$Help,
	[switch]$Debug,
	[switch]$EditConfig,
    [switch]$Start,
    [switch]$Stop,
    [switch]$Status,
	[Alias("Notifications")][switch]$Notify,
	[Alias("DoNotUpgrade")][switch]$NoUpgrades,
	[int]$WaitTime
 )

Write-Host "CCU.ps1 v0.1.0-RC1 (2023/11/17) - (unofficial) Chocolatey Continuous Upgrader" -Foreground White
Write-Host "Copyleft 2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

$Background=$True
$CCUconfig="$env:chocolateyToolsLocation\BCURRAN3\CCU.config"
$RunningFile="$env:chocolateyToolsLocation\BCURRAN3\CCU-running.tmp"
$StatusFile="$env:chocolateyToolsLocation\BCURRAN3\CCU-status.tmp"
$toolsdir=(Split-Path -parent $MyInvocation.MyCommand.Definition)
if (!$env:ChocolateyToolsLocation) {$env:ChocolateyToolsLocation = "$ENV:SystemDrive\tools"}

## START FUNCTIONS

# Create config file to set defaults
function create_config{
	Write-Host "  ** Creating new CCU config file:`n" -Foreground Yellow
	if (Test-Path "$CCUconfig") {Remove-Item "$CCUconfig" -Force}
	
	do {
		$ConfigNotify=Read-Host "     CCU notifications (True/False)? "
	} until (($ConfigNotify -eq 'true') -or ($ConfigNotify -eq 'false'))
	do {
		$ConfigNoUpgrades=Read-Host "     CCU automatic upgrades (True/False)? "
	} until (($ConfigNoUpgrades -eq 'true') -or ($ConfigNoUpgrades -eq 'false'))
	do {
		[int]$ConfigWaitTime=Read-Host "     CCU wait time between checking for upgrades (# of minutes)? "
	} until ($ConfigWaitTime -is [int])
	
	$ConfigFile = New-Object System.XMl.XmlTextWriter("$CCUconfig", $Null)
	$ConfigFile.Formatting = 'Indented'
    $ConfigFile.Indentation = 1
    $ConfigFile.IndentChar = "`t"
	$ConfigFile.WriteStartDocument()
	$ConfigFile.WriteStartElement("Preferences")
    $ConfigFile.WriteElementString("Notify","$ConfigNotify")
	$ConfigFile.WriteElementString("NoUpgrades","$ConfigNoUpgrades")
	$ConfigFile.WriteElementString("WaitTime","$ConfigWaitTime")
	$ConfigFile.WriteEndDocument()
    $ConfigFile.Flush()
    $ConfigFile.Close()
	Write-Host "`n  ** Created $CCUconfig`n" -Foreground Magenta
}

function print_footer{
	Write-Host "Found CCU.ps1 useful?" -ForegroundColor White
    Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
    Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
}

# Import preferences from config file
function read_config{
    [xml]$ConfigFile = Get-Content "$CCUconfig"
    if ($ConfigFile.Preferences.Notify -eq 'true') {[bool]$env:Notify=$True} else {[bool]$env:Notify=$False}
    if ($ConfigFile.Preferences.NoUpgrades -eq 'true') {[bool]$env:NoUpgrades=$False} else {[bool]$env:NoUpgrades=$True}
    if ($ConfigFile.Preferences.WaitTime) {[int]$env:WaitTime=$ConfigFile.Preferences.WaitTime} else {[int]$env:WaitTime=30}
}

## END FUNCTIONS

############################### NEEDS LOGIC DEBUGGING AND TESTING

if (Test-Path "$CCUconfig") {
	read_config
	if (!(Test-Path "$RunningFile")){
	$Notify=[bool]$env:Notify
	$NoUpgrades=[bool]$env:NoUpgrades
	$WaitTime=[int]$env:WaitTime
	} else {
		$Status=$True
	}
}
if ($Debug) {$Start=$True; $Background=$False}
if ($Notify){$env:Notify=$True; $Start=$True} else {$env:Notify=$False}
if ($NoUpgrades){$env:AutoUpgrade=$False; $Start=$True} else {$env:AutoUpgrade=$True}
if ($WaitTime) {$Start=$True}
if (!$WaitTime) {$WaitTime="30"} ; $env:WaitTime=$WaitTime
if ($Stop) {$Help=$False; $Start=$False; $Status=$False}

############################### NEEDS LOGIC DEBUGGING AND TESTING

if ($EditConfig) {create_config; return}

#if (!$Start -and !$Stop -and !$Status -and !$Help -and !$Notify -and !$NoUpgrades -and !$Debug -and !$EditConfig -and !$WaitTime) {
if (!$Start -and !$Stop -and !$Status) {
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
	Write-Host "    Show CCU status."
	Write-Host " -Notify (assumes -Start)"
	Write-Host "    Send notifications when upgrades are found."
	Write-Host " -NoUpgrades (assumes -Start)"
	Write-Host "    Disable auto-upgrading of packages."
	Write-Host " #  (assumes -Start)"
	Write-Host "    Number of minutes to wait between checks (default 30)."
	Write-Host " -EditConfig"
	Write-Host "    Create CCU config file."
	Write-Host " -Help, -?"
	Write-Host "    This menu."
	Write-Host 
	Write-Host "EXAMPLE:" -Foreground Magenta
	Write-Host " CCU -Start 60`n"
	return
}

if ($Status){
	if (Test-Path "$RunningFile"){
		Write-Host "  ** CCU is running." -Foreground Yellow
		} else {
			Write-Host "  ** CCU is not running." -Foreground Yellow
		}
	if (Test-Path "$StatusFile"){
		foreach($line in Get-Content "$StatusFile") {
			Write-Host "$line" -Foreground Yellow
			}
	}
	if (Get-Process -Name choco -ErrorAction SilentlyContinue){
		Write-Host "  ** Chocolatey is installing an upgrade.`n" -Foreground Yellow
	}
	Write-Host ""
	print_footer
	return
}

if ($Start) {
	if (Test-Path "$RunningFile"){
		Write-Host "  ** CCU is already running!`n" -Foreground Yellow
		return
	}
	if ($Background){
		$CCUProcess = Start-Process PowerShell -ArgumentList '$host.ui.RawUI.WindowTitle=''Chocolatey Continuous Upgrader''; Import-Module ./CCU.psm1; for (;;) {keep_checking}' -WindowStyle Hidden -WorkingDirectory "$toolsDir" -PassThru
		$CCUProcess | Export-Clixml -Path "$RunningFile"
	}
	if ($Debug){
		$CCUProcess = Start-Process PowerShell -ArgumentList '$host.ui.RawUI.WindowTitle=''Chocolatey Continuous Upgrader''; Import-Module ./CCU.psm1; for (;;) {keep_checking}' -WindowStyle Normal -WorkingDirectory "$toolsDir" -PassThru
		$CCUProcess | Export-Clixml -Path "$RunningFile"
	}
	Write-Host "  ** CCU STARTED." -Foreground Yellow
	if ($Notify) {Write-Host "  ** CCU notifications ENABLED." -Foreground Yellow} else {Write-Host "  ** CCU notifications DISABLED." -Foreground Yellow}
	if ($NoUpgrades) {Write-Host "  ** CCU package upgrades DISABLED." -Foreground Yellow} else {Write-Host "  ** CCU package upgrades ENABLED." -Foreground Yellow}
	Write-Host "  ** CCU will check for upgrades every $WaitTime minutes.`n" -Foreground Yellow
	print_footer
	return
}

if ($Stop){
	if (Get-Process -Name choco -ErrorAction SilentlyContinue){
		Write-Host "  ** Chocolatey is installing an upgrade. Waiting for it to finish..." -Foreground Yellow
		while (Get-Process -Name choco -ErrorAction SilentlyContinue) {Start-Sleep 1}
	}
	if (Test-Path "$RunningFile") {$CCUProcess = Import-Clixml -Path "$RunningFile"}
    $CCUProcess | Stop-Process -ErrorAction SilentlyContinue
	if (!$?) {
		Write-Host "  ** CCU already STOPPED!`n" -Foreground Yellow
	} else {
		Write-Host "  ** CCU STOPPED.`n" -Foreground Yellow
	}
	if (Test-Path "$RunningFile"){Remove-Item "$RunningFile"}
	if (Test-Path "$StatusFile"){Remove-Item "$StatusFile"}
	print_footer
	return
}

