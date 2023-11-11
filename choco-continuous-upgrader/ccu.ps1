# $ErrorActionPreference = 'Stop'
# CCU.ps1 Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

param (
    [switch]$OnlyNotify,
    [switch]$Start,
    [switch]$Stop,
	[int]$WaitTime
 )

if ($OnlyNotify){$AutoUpgrade=$False} else {$AutoUpgrade=$True}

Write-Host "CCU.ps1 v2023.11.11 - (unofficial) Chocolatey Continuous Upgrader" -Foreground White
Write-Host "Copyleft 2023 Bill Curran (bcurran3@yahoo.com) - free for personal and commercial use`n" -Foreground White

function keep_checking{
$FoundUpgrades=$False

if (!($AutoUpgrade)){Write-Host "  ** Automatic upgrades DISABLED, notifications only." -Foreground Red}

# get list of installed packages
Write-Host "  ** Getting list of installed Chocolatey packages..." -Foreground Magenta
Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\lib).count) installed Chocolatey packages" -Foreground Green
Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\extensions).count) installed Chocolatey extensions" -Foreground Green
Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\hooks).count) installed Chocolatey hooks" -Foreground Green
$InstalledPackages = Get-Childitem $env:ChocolateyInstall\lib | Split-Path -Leaf
$InstalledPackages = $InstalledPackages + (Get-Childitem $env:ChocolateyInstall\extensions | Split-Path -Leaf)
$InstalledPackages = $InstalledPackages + (Get-Childitem $env:ChocolateyInstall\hooks | Split-Path -Leaf)

#choco feedburner get links
Write-Host "  ** Getting Feedburner list of recently published Chocolatey packages..." -Foreground Magenta
[xml]$feed = Invoke-WebRequest -Uri 'https://feeds.feedburner.com/chocolatey' | Select-Object -ExpandProperty Content

# Get all the link elements in the RSS feed
$links = $feed.rss.channel.item.link

Write-Host "  ** Found $($links.count) Chocolatey packages in Feedburner list." -Foreground Green
Write-Host "  ** Latest published Chocolatey package was at $($feed.rss.channel.item[0].updated)" -Foreground Green
Sleep 2

# TDL: Need to get versions of packages
# from .chocolatey would be nice if clean
# from .nuspec is going to be very io intensive

# Output the links
for ($link=0; $link -lt $links.count; $link++)
{
    $feedpackage = $links[$link] | split-path | split-path -leaf
	$feedversion = $links[$link] | split-path -leaf

    for ($installed=0; $installed -lt $InstalledPackages.count; $installed++)
    {
		if ($InstalledPackages[$installed] -eq $feedpackage)
	    {
			[xml]$nuspecFile = Get-Content "$env:ChocolateyInstall\lib\$feedpackage\$feedpackage.nuspec"
            $InstalledVersion=$nuspecFile.package.metadata.version
			if ($feedversion -gt $InstalledVersion)
			{
				$FoundUpgrades=$True
				Write-Host "  ** Found update for $feedpackage (v$feedversion published $($feed.rss.channel.item[$link].updated))" -Foreground Magenta
				if ($AutoUpgrade) {& choco upgrade $feedpackage}
			}
	    }
    }
}
if (!($FoundUpgrades)) {Write-Host "  ** No packages to upgrade." -Foreground Magenta}
Write-Host "  ** Waiting $WaitTime minutes before checking again... **" -Foreground Cyan
Sleep $($WaitTime*60)

}

if ($Start -or $OnlyNotify) {
	if ($WaitTime -eq $null) {$WaitTime=30}
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
