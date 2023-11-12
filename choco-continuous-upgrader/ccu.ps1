#Requires -RunAsAdministrator
# $ErrorActionPreference = 'Stop'
# CCU.ps1 (Chocolatey Continuous Upgrader) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

param (
    [switch]$OnlyNotify,
    [switch]$Start,
    [switch]$Stop,
	[int]$WaitTime
 )

Write-Host "CCU.ps1 v0.1.0-alpha (2023/11/11) - (unofficial) Chocolatey Continuous Upgrader" -Foreground White
Write-Host "Copyleft 2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

if ($OnlyNotify){$AutoUpgrade=$False} else {$AutoUpgrade=$True}
if (Get-Module -ListAvailable -Name BurntToast) {$ToastAvailable=$True} else {$ToastAvailable=$False}
if (!($WaitTime)) {$WaitTime=30}

# Send toast messages to foreground about available updates
function send_toast{
	if ((Get-Service WinRM).Status -eq 'Stopped') {Start-Service 'WinRM' -ErrorAction SilentlyContinue}
	if ((Get-Service WinRM).Status -eq 'Running') {
		Invoke-Command -ComputerName $(hostname) -ArgumentList $FeedPackage,$FeedPackageVersion -ScriptBlock {param([string]$FeedPackage, [string]$FeedPackageVersion) Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; New-BurntToastNotification -Text "Chocolatey Continuous Updater:`n", "$Feedpackage v$FeedPackageVersion `nUPGRADE AVAILABLE." -AppLogo "$env:PUBLIC\Pictures\choco.ico"}
	}
}

# Meat & Potatoes
function keep_checking{
$FoundUpgrades=$False

if (!($AutoUpgrade)){Write-Host "  ** Automatic upgrades DISABLED, notifications only." -Foreground Red}

# Get list of installed packages
Write-Host "  ** Getting list of installed Chocolatey packages..." -Foreground Magenta
Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\lib).count) installed Chocolatey packages" -Foreground Green
Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\extensions).count) installed Chocolatey extensions" -Foreground Green
Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\hooks).count) installed Chocolatey hooks" -Foreground Green
$InstalledPackages = Get-Childitem $env:ChocolateyInstall\lib | Split-Path -Leaf
$InstalledPackages = $InstalledPackages + (Get-Childitem $env:ChocolateyInstall\extensions | Split-Path -Leaf)
$InstalledPackages = $InstalledPackages + (Get-Childitem $env:ChocolateyInstall\hooks | Split-Path -Leaf)

# Get Feedburner list of updated packages
Write-Host "  ** Getting Feedburner list of recently published Chocolatey packages..." -Foreground Magenta
try {
	[xml]$feed = Invoke-WebRequest -Uri 'https://feeds.feedburner.com/chocolatey' | Select-Object -ExpandProperty Content
}
catch {
    if ( $_.Exception.Response.StatusCode.Value__ -eq 404 )
	{
        Write-Host "  ** 404 error getting https://feeds.feedburner.com/chocolatey" -Foreground Red
		Write-Host "  ** Waiting $WaitTime minutes before checking again... **" -Foreground Cyan
		Sleep $($WaitTime*60)
		return
    }
    else {
        Write-Host "False response..." -Foreground Red
    }
}
$links = $feed.rss.channel.item.link

Write-Host "  ** Found $($links.count) Chocolatey packages in Feedburner list." -Foreground Green
Write-Host "  ** $($feed.rss.channel.item[0].title) is the latest Chocolatey package published at $([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $feed.rss.channel.item[0].updated), $(Get-TimeZone).id))." -Foreground Green

# Upgrade and/or notify updated packages
for ($link=0; $link -lt $links.count; $link++)
{
    $FeedPackage = $links[$link] | split-path | split-path -leaf
	$FeedPackageVersion = $links[$link] | split-path -leaf

    for ($installed=0; $installed -lt $InstalledPackages.count; $installed++)
    {
		if ($InstalledPackages[$installed] -eq $FeedPackage)
	    {
			[xml]$nuspecFile = Get-Content "$env:ChocolateyInstall\lib\$FeedPackage\$FeedPackage.nuspec"
            $InstalledVersion=$nuspecFile.package.metadata.version
			if ($FeedPackageVersion -gt $InstalledVersion)
			{
				$FoundUpgrades=$True
                Write-Host "  ** Found update for $FeedPackage (v$FeedPackageVersion published $([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $feed.rss.channel.item[$link].updated), $(Get-TimeZone).id)))" -Foreground Magenta
				if ($ToastAvailable) {send_toast}
				if ($AutoUpgrade) {& choco upgrade $FeedPackage}
			}
	    }
    }
}
if (!($FoundUpgrades)) {Write-Host "  ** No packages to upgrade." -Foreground Magenta}
Write-Host "  ** Waiting $WaitTime minutes before checking again... **" -Foreground Cyan
Sleep $($WaitTime*60)

}

if ($Start -or $OnlyNotify) {
	for (;;) {keep_checking}
} else {
	Write-Host "PARAMETERS:" -Foreground Yellow
	Write-Host " -Start - start checking for and install upgrades." -Foreground Yellow
	Write-Host " -Stop  - stop checking for upgrades. (NOT IMPLEMENTED)" -Foreground Yellow
	Write-Host " -OnlyNotify - start checking for upgrades but do not install them." -Foreground Yellow
	Write-Host " # of minutes to wait between checks (default 30)" -Foreground Yellow
	Write-Host 
	Write-Host "EXAMPLE:" -Foreground Yellow
	Write-Host " CCU -Start 60`n" -Foreground Yellow
	Write-Host 
}

# TDL:
# Move functions to PSM
# Use Start-Job to call functions to run in background
# Implement -Stop to Remove-Job
