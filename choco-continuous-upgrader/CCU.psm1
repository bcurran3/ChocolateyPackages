# CCU.psm1 (Chocolatey Continuous Upgrader) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

function print_info {
	
	param (
    [string]$message,
    [string]$color
 )

	Write-Host "$message" -Foreground "$color"
}

# TODO: add 2nd print info function for less notifications options

function send_msg{
	& msg * /time:3 "Chocolatey Continuous Upgrader:`n$Feedpackage v$FeedPackageVersion`nUPGRADE AVAILABLE."
}

# Send toast messages to foreground about available updates
function send_toast{
	if ((Get-Service WinRM).Status -eq 'Stopped') {Start-Service 'WinRM' -ErrorAction SilentlyContinue}
	if ((Get-Service WinRM).Status -eq 'Running') {
		Invoke-Command -ComputerName $(hostname) -ArgumentList $FeedPackage,$FeedPackageVersion -ScriptBlock {param([string]$FeedPackage, [string]$FeedPackageVersion) Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; New-BurntToastNotification -Text "Chocolatey Continuous Updater:`n", "$Feedpackage v$FeedPackageVersion `nUPGRADE AVAILABLE." -AppLogo "$env:PUBLIC\Pictures\choco.ico"}
	}
}

function send_notification {
	if ($env:ToastAvailable) {send_toast} else {send_msg}
}

# Meat & Potatoes
function keep_checking{
	
    $FoundUpgrades=$False
	if (!($env:WaitTime)) {$env:WaitTime=30}
	
    if (!($env:AutoUpgrade)){print_info "  ** Automatic upgrades DISABLED, notifications only." "Red"}

    # Get list of installed packages
	print_info "  ** 'CCU -Stop' to stop." "Yellow"
    print_info "  ** Getting list of installed Chocolatey packages..." "Magenta"
    print_info "  ** Found $((Get-Childitem $env:ChocolateyInstall\lib).count) installed Chocolatey packages" "Green"
    print_info "  ** Found $((Get-Childitem $env:ChocolateyInstall\extensions).count) installed Chocolatey extensions" "Green"
    print_info "  ** Found $((Get-Childitem $env:ChocolateyInstall\hooks).count) installed Chocolatey hooks" "Green"
    $InstalledPackages = Get-Childitem $env:ChocolateyInstall\lib | Split-Path -Leaf
    $InstalledPackages = $InstalledPackages + (Get-Childitem $env:ChocolateyInstall\extensions | Split-Path -Leaf)
    $InstalledPackages = $InstalledPackages + (Get-Childitem $env:ChocolateyInstall\hooks | Split-Path -Leaf)

    # Get Feedburner list of updated packages
    print_info "  ** Getting Feedburner list of recently published Chocolatey packages..." "Magenta"
    try {
    	[xml]$feed = Invoke-WebRequest -Uri 'https://feeds.feedburner.com/chocolatey' | Select-Object -ExpandProperty Content
    }
    catch {
        if ( $_.Exception.Response.StatusCode.Value__ -eq 404 )
    	{
            print_info "  ** 404 error getting https://feeds.feedburner.com/chocolatey" "Red"
    		print_info "  ** Waiting $env:WaitTime minutes before checking again..." "Cyan"
    		Sleep $([int]$env:WaitTime*60)
    		return
        }
        else {
            print_info "False response..." "Red"
        }
    }
    $links = $feed.rss.channel.item.link

    print_info "  ** Found $($links.count) Chocolatey packages in Feedburner list." "Green"
    print_info "  ** $($feed.rss.channel.item[0].title) is the latest Chocolatey package published at $([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $feed.rss.channel.item[0].updated), $(Get-TimeZone).id))." "Green"

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
                    print_info "  ** Found update for $FeedPackage (v$FeedPackageVersion published $([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $feed.rss.channel.item[$link].updated), $(Get-TimeZone).id)))" "Magenta"
    				if ($env:Notify) {send_notification}
# TODO: Debug AutoUpgrade condition not working for some reason
#    				if ($env:AutoUpgrade) {& choco upgrade $FeedPackage -y}
                    Write-Host "  ** DEBUG: env:AutoUpgrade is set to $env:AutoUpgrade" -Foreground Yellow
					if ($env:AutoUpgrade) {Write-Host "  ** DEBUG: 'choco upgrade $Feedpackage -y' would run here" -Foreground Yellow}
    			}
    	    }
        }
    }
    if (!($FoundUpgrades)) {print_info "  ** No packages to upgrade." "Magenta"}
    print_info "  ** Waiting $env:WaitTime minutes before checking again..." "Cyan"
    Sleep $([int]$env:WaitTime*60)
}
