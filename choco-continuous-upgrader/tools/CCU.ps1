#Requires -RunAsAdministrator
#$ErrorActionPreference = 'Stop'
# CCU.ps1 (Chocolatey Continuous Upgrader) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

param (
	[Alias("?")][switch]$Help,
    [switch]$Start,
    [switch]$Stop,
    [switch]$Status,
	[Alias("Notifications")][switch]$Notify,
	[Alias("DoNotUpgrade")][switch]$NoUpgrades,
	[Alias("UpgradeAll")][switch]$UpgradeAllFirst,
	[Alias("EditConfig")][switch]$CreateConfig,
	[switch]$DeleteConfig,
	[Alias("CreateTask")][switch]$CreateScheduledTask,
	[Alias("DeleteTask")][switch]$DeleteScheduledTask,
    [Alias("GeekMode")][switch]$Debug,
	[int]$WaitTime
 )

Write-Host "CCU.ps1 v1.0.1 (2023/12/11) - (unofficial) Chocolatey Continuous Upgrader" -Foreground White
Write-Host "Copyleft 2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

$ErrorActionPreference = 'Stop'
$Background=$True
$CCUconfig="$env:chocolateyToolsLocation\BCURRAN3\CCU.config"
$RunningFile="$env:chocolateyToolsLocation\BCURRAN3\CCU-running.tmp"
$StatusFile="$env:chocolateyToolsLocation\BCURRAN3\CCU-status.tmp"
$execdir=(Split-Path -parent $MyInvocation.MyCommand.Definition)
if (!$env:ChocolateyToolsLocation) {$env:ChocolateyToolsLocation = "$ENV:SystemDrive\tools"}

function create_config {
	Write-Host "  ** Creating CCU config file:`n" -Foreground Magenta
	if (Test-Path "$CCUconfig") {Remove-Item "$CCUconfig" -Force}
	
	do {
		$ConfigNotify=Read-Host "     CCU notifications (True/False)? "
	} until (($ConfigNotify -eq 'true') -or ($ConfigNotify -eq 'false'))
	do {
		$ConfigNoUpgrades=Read-Host "     Disable CCU automatic upgrades (True/False)? "
	} until (($ConfigNoUpgrades -eq 'true') -or ($ConfigNoUpgrades -eq 'false'))
	do {
		$ConfigUpgradeAllFirst=Read-Host "     CCU upgrade all packages on run? (True/False)? "
	} until (($ConfigUpgradeAllFirst -eq 'true') -or ($ConfigUpgradeAllFirst -eq 'false'))
	do {
		[int]$ConfigWaitTime=Read-Host "     CCU wait time (# of minutes)? "
	} until ($ConfigWaitTime -is [int])
	
	$ConfigFile = New-Object System.XMl.XmlTextWriter("$CCUconfig", $Null)
	$ConfigFile.Formatting = 'Indented'
    $ConfigFile.Indentation = 1
    $ConfigFile.IndentChar = "`t"
	$ConfigFile.WriteStartDocument()
	$ConfigFile.WriteStartElement("Preferences")
    $ConfigFile.WriteElementString("Notify","$ConfigNotify")
	$ConfigFile.WriteElementString("NoUpgrades","$ConfigNoUpgrades")
	$ConfigFile.WriteElementString("UpgradeAllFirst","$ConfigUpgradeAllFirst")
	$ConfigFile.WriteElementString("WaitTime","$ConfigWaitTime")
	$ConfigFile.WriteEndDocument()
    $ConfigFile.Flush()
    $ConfigFile.Close()
	Write-Host "`n  ** Created $CCUconfig." -Foreground Magenta
	if (Test-Path "$RunningFile") {
		Write-Host "  ** Restart CCU for defaults to take effect." -Foreground Yellow
	}
	Write-Host ""
}

function delete_config {
	if (Test-Path "$CCUconfig") {
		Remove-Item "$CCUconfig"
	    Write-Host "  ** Deleted $CCUconfig`n" -Foreground Magenta
	} else {
		Write-Host "  ** CCU config file not found.`n" -Foreground Yellow
	}
}

function create_scheduledtask {
	if (!(Test-Path "$CCUconfig")) {
		Write-Host "  ** CCU config file not found." -Foreground Yellow
		Write-Host "  ** CCU needs defaults to run as a scheduled task." -Foreground Yellow
		Write-Host "  ** Run `'CCU -CreateConfig`' to set defaults.`n" -Foreground Yellow
		return
	}
	Write-Host "  ** Creating CCU scheduled task.`n" -Foreground Magenta
    $ErrorActionPreference = 'SilentlyContinue'
    $GotTask = (&schtasks.exe /query /tn "CCU") 2> $null
    $ErrorActionPreference = 'Stop'
    if ($GotTask){
      &schtasks.exe /DELETE /TN "CCU" /F
    }
    SchTasks /Create /SC ONSTART /RU $(whoami) /RP /RL HIGHEST /TN "CCU" /TR "%ChocolateyInstall%\bin\CCU.bat" /F
    Write-Host "`n  ** CCU will run at Windows startup.`n" -Foreground Yellow
}

function delete_scheduledtask {
    $ErrorActionPreference = 'SilentlyContinue'
    $GotTask = (&schtasks.exe /query /tn "CCU") 2> $null
    $ErrorActionPreference = 'Stop'
    if ($GotTask){
      &schtasks.exe /DELETE /TN "CCU" /F
	  Write-Host "`n  ** CCU scheduled task deleted.`n" -Foreground Magenta
    } else {
		Write-Host "  ** No CCU scheduled task to delete.`n" -Foreground Yellow
	}
}

function print_footer {
	Write-Host "Found CCU.ps1 useful?" -ForegroundColor White
    Write-Host "Buy me a beer at https://www.paypal.me/bcurran3donations" -ForegroundColor White
    Write-Host "Become a patron at https://www.patreon.com/bcurran3" -ForegroundColor White
}

if (Test-Path "$RunningFile") {
	$created=(Get-ChildItem "$RunningFile").LastWriteTime
	$rebooted=(Get-CimInstance -ClassName win32_operatingsystem | select csname, lastbootuptime).LastBootUpTime
	if ($created -lt $rebooted) {
		Write-Host " ** CCU detected a reboot while previously running." -Foreground Yellow
		Write-Host " ** Deleting temp file.`n" -Foreground Magenta
		Remove-Item $RunningFile
		}
}

if ($CreateConfig) {create_config; return}
if ($DeleteConfig) {delete_config; return}
if ($CreateScheduledTask) {create_scheduledtask; return}
if ($DeleteScheduledTask) {delete_scheduledtask; return}

if (!$Start -and !$Stop -and !$Status -and !$Help -and !$Notify -and !$NoUpgrades -and !$Debug -and !$WaitTime) {
	$MiniHelp=$True
	if (Test-Path "$CCUconfig") {
		[xml]$ConfigFile = Get-Content "$CCUconfig"
        if ($ConfigFile.Preferences.Notify -eq 'true') {$Notify=$True}
        if ($ConfigFile.Preferences.NoUpgrades -eq 'true') {$NoUpgrades=$True}
		if ($ConfigFile.Preferences.UpgradeAllFirst -eq 'true') {$UpgradeAllFirst=$True}
        if ($ConfigFile.Preferences.WaitTime) {$WaitTime=$ConfigFile.Preferences.WaitTime}
	    $Start=$True
		$MiniHelp=$False
	}
	if (Test-Path "$RunningFile") {
		$Start=$False
		$Status=$True
		$MiniHelp=$False
	}
	if ($MiniHelp) {
		Write-Host "  ** Please run 'CCU -?' or 'CCU -help' for help menu.`n" -Foreground White
		return
	}
}

if ($Debug) {$Start=$True; $Background=$False}
if ($Notify) {$env:Notify=$True; $Start=$True} else {$env:Notify=$False}
if ($NoUpgrades) {$env:AutoUpgrade=$False; $Start=$True} else {$env:AutoUpgrade=$True}
if ($UpgradeAllFirst) {$env:UpgradeAllFirst=$True} else {$env:UpgradeAllFirst=$False}
if ($WaitTime) {$Start=$True}; if (!$WaitTime) {$WaitTime="30"} ; $env:WaitTime=$WaitTime
if ($Stop) {$Help=$False; $Start=$False; $Status=$False}

if ( $Help ) {
	Write-Host "OPTIONS AND SWITCHES:" -Foreground Magenta
	Write-Host " -Start"
	Write-Host "    Start checking for and install upgrades."
	Write-Host " -Stop"
	Write-Host "    Stop checking for upgrades."
	Write-Host " -Status"
	Write-Host "    Show CCU status."
	Write-Host " -Notify, -Notifications (assumes -Start)"
	Write-Host "    Send notifications when upgrades are found."
	Write-Host " -NoUpgrades, -DoNotUpgrade (assumes -Start)"
	Write-Host "    Disable auto-upgrading of packages."
	Write-Host " -UpgradeAll, -UpgradeAllFirst (assumes -Start)"
	Write-Host "    Run `'choco upgrade all -y`' before continuously checking for upgrades."
	Write-Host " #  (assumes -Start)"
	Write-Host "    Number of minutes to wait between checks for upgrades (default 30)."
	Write-Host " -CreateConfig, -EditConfig"
	Write-Host "    Creates CCU config file with your preferences."
	Write-Host " -DeleteConfig"
	Write-Host "    Deletes the CCU config file."
	Write-Host " -CreateTask, -CreateScheduledTask"
	Write-Host "    Creates a scheduled task to run CCU on system boot."
	Write-Host " -DeleteTask, -DeleteScheduledTask"
	Write-Host "    Deletes the scheduled task to run CCU on system boot."
	Write-Host " -GeekMode, -Debug (assumes -Start)"
	Write-Host "    Just for fun."
	Write-Host " -Help, -?"
	Write-Host "    This menu.`n"
	return
}

if ($Status) {
	if (Test-Path "$RunningFile") {
		Write-Host "  ** CCU is running." -Foreground Yellow
		if (Test-Path "$StatusFile") {
			foreach($line in Get-Content "$StatusFile") {
				Write-Host "$line" -Foreground Yellow
			}
		} else {
			Write-Host "  ** ERROR: Status file not found. Run `'CCU -Status`' again." -Foreground Red
			Write-Host "  ** ERROR: If this error continues, Run `'CCU -Stop`'" -Foreground Red
		}
	} else {
		Write-Host "  ** CCU is not running." -Foreground Yellow
	}
	if (Get-Process -Name choco -ErrorAction SilentlyContinue) {
		Write-Host "  ** Chocolatey is currently running.`n" -Foreground Yellow
	}
	Write-Host ""
	print_footer
	return
}

if ($Start) {
	if (Test-Path "$RunningFile") {
		Write-Host "  ** CCU is already running!`n" -Foreground Yellow
		return
	}
	if ($Background) {
		$CCUProcess = Start-Process PowerShell -ArgumentList '$host.ui.RawUI.WindowTitle=''Chocolatey Continuous Upgrader''; Import-Module ./CCU.psm1; for (;;) {keep_checking}' -WindowStyle Hidden -WorkingDirectory "$execdir" -PassThru
		$CCUProcess | Export-Clixml -Path "$RunningFile"
	}
	if ($Debug) {
		$CCUProcess = Start-Process PowerShell -ArgumentList '$host.ui.RawUI.WindowTitle=''Chocolatey Continuous Upgrader''; Import-Module ./CCU.psm1; for (;;) {keep_checking}' -WindowStyle Normal -WorkingDirectory "$execdir" -PassThru
		$CCUProcess | Export-Clixml -Path "$RunningFile"
	}
	Write-Host "  ** CCU STARTED." -Foreground Yellow
	if ($Notify) {Write-Host "  ** CCU notifications are ENABLED." -Foreground Yellow} else {Write-Host "  ** CCU notifications are DISABLED." -Foreground Yellow}
	if ($NoUpgrades) {Write-Host "  ** CCU package upgrades are DISABLED." -Foreground Yellow} else {Write-Host "  ** CCU package upgrades are ENABLED." -Foreground Yellow}
	Write-Host "  ** CCU will check for upgrades every $WaitTime minutes.`n" -Foreground Yellow
	print_footer
	return
}

if ($Stop) {
	if (Get-Process -Name choco -ErrorAction SilentlyContinue) {
		Write-Host "  ** Chocolatey is currently running. Waiting for it to finish..." -Foreground Yellow
		while (Get-Process -Name choco -ErrorAction SilentlyContinue) {Start-Sleep 1}
	}
	if (Test-Path "$RunningFile") {$CCUProcess = Import-Clixml -Path "$RunningFile"}
    $CCUProcess | Stop-Process -ErrorAction SilentlyContinue
	if (!$?) {
		Write-Host "  ** CCU already STOPPED!`n" -Foreground Yellow
	} else {
		Write-Host "  ** CCU STOPPED.`n" -Foreground Yellow
	}
	if (Test-Path "$RunningFile") {Remove-Item "$RunningFile" -Force}
	if (Test-Path "$StatusFile") {Remove-Item "$StatusFile" -Force}
	print_footer
	return
}
