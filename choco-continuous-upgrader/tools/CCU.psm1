# CCU.psm1 (Chocolatey Continuous Upgrader) Copyleft 2023 by Bill Curran AKA BCURRAN3
# LICENSE: GNU GPL v3 - https://www.gnu.org/licenses/gpl.html
# Open a GitHub issue at https://github.com/bcurran3/ChocolateyPackages/issues if you have suggestions for improvement.

if (Get-Module -ListAvailable -Name BurntToast) {$ToastAvailable=$True} else {$ToastAvailable=$False}
if (!$env:ChocolateyToolsLocation) {$env:ChocolateyToolsLocation = "$ENV:SystemDrive\tools"}
$StatusFile="$env:chocolateyToolsLocation\BCURRAN3\CCU-status.tmp"

if (Test-Path "$StatusFile") {Remove-Item "$StatusFile" -Force}
if ($env:AutoUpgrade -eq 'true') {$AutoUpgrade=$True} else {$AutoUpgrade=$False}
if ($env:Notify -eq 'true') {$Notify=$True} else {$Notify=$False}
if ($env:WaitTime -eq '') {$WaitTime=30} else {$WaitTime=$env:WaitTime}


# Send Windows MSG messages to foreground about available upgrades
function send_msg {
	& msg * /time:3 "Chocolatey Continuous Upgrader:`n$Feedpackage v$FeedPackageVersion`nUPGRADE AVAILABLE."
}

# Send toast messages to foreground about available upgrades
function send_toast {
	if ((Get-Service WinRM).Status -eq 'Stopped') {Start-Service 'WinRM' -ErrorAction SilentlyContinue}
	if ((Get-Service WinRM).Status -eq 'Running') {
		Invoke-Command -ComputerName $(hostname) -ArgumentList $FeedPackage,$FeedPackageVersion -ScriptBlock {param([string]$FeedPackage, [string]$FeedPackageVersion) Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; New-BurntToastNotification -Text "Chocolatey Continuous Upgrader:`n", "$Feedpackage v$FeedPackageVersion `nUPGRADE AVAILABLE." -AppLogo "$env:PUBLIC\Pictures\choco.ico"}
	}
}

function send_notification {
	if ($ToastAvailable -eq $True) {send_toast} else {send_msg}
}

# Meat and Potatoes
function keep_checking {
    $FoundUpgrades=$False
	if (!$WaitTime) {$WaitTime=30}
	Clear-Host
	if ($Notify) {
		Write-Host "  ** CCU notifications ENABLED." -Foreground Yellow
		Add-Content -Path "$StatusFile" -Value "  ** CCU notifications ENABLED."
	} else {
		Write-Host "  ** CCU Notifications DISABLED." -Foreground Yellow
		Add-Content -Path "$StatusFile" -Value "  ** CCU notifications DISABLED."
	}
    if ($AutoUpgrade) {
		Write-Host "  ** CCU package upgrades ENABLED." -Foreground Yellow
		Add-Content -Path "$StatusFile" -Value "  ** CCU package upgrades ENABLED."
	} else {
		Write-Host "  ** CCU package upgrades DISABLED." -Foreground Red
		Add-Content -Path "$StatusFile" -Value "  ** CCU package upgrades DISABLED."
	}
	Add-Content -Path "$StatusFile" -Value "  ** CCU is checking for upgrades every $WaitTime minutes."
    # Get list of installed packages
    Write-Host "  ** Getting list of installed Chocolatey packages..." -Foreground Magenta
    Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\lib).count) installed Chocolatey packages" -Foreground Green
    Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\extensions).count) installed Chocolatey extensions" -Foreground Green
    Write-Host "  ** Found $((Get-Childitem $env:ChocolateyInstall\hooks).count) installed Chocolatey hooks" -Foreground Green
    $InstalledPackages = Get-Childitem $env:ChocolateyInstall\lib | Split-Path -Leaf
    $InstalledPackages = $InstalledPackages + (Get-Childitem $env:ChocolateyInstall\extensions | Split-Path -Leaf)
    $InstalledPackages = $InstalledPackages + (Get-Childitem $env:ChocolateyInstall\hooks | Split-Path -Leaf)

    # Get Feedburner list of upgraded packages
    Write-Host "  ** Getting Feedburner list of recently published Chocolatey packages..." -Foreground Magenta
    try {
    	[xml]$feed = Invoke-WebRequest -Uri 'https://feeds.feedburner.com/chocolatey' | Select-Object -ExpandProperty Content
    }
    catch {
        if ( $_.Exception.Response.StatusCode.Value__ -eq 404 ) {
            Write-Host "  ** 404 error getting https://feeds.feedburner.com/chocolatey" -Foreground Red
			$WaitTimeRemaining=$WaitTime
	        Write-Host "  ** Waiting $WaitTimeRemaining minutes before checking again...`r" -Foreground Cyan -NoNewLine
            while ($WaitTimeRemaining -gt 0) {
				Write-Host "  ** Waiting $WaitTimeRemaining minutes before checking again...   `r" -Foreground Cyan -NoNewLine
	            Sleep 60
	            $WaitTimeRemaining=$WaitTimeRemaining-1
			}
    		return
        } else { Write-Host "  ** Bad response..." -Foreground Red }
    }
    $links = $feed.rss.channel.item.link

    Write-Host "  ** Found $($links.count) Chocolatey packages in Feedburner list." -Foreground Green
    Write-Host "  ** $($feed.rss.channel.item[0].title) is the latest Chocolatey package published at $([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $feed.rss.channel.item[0].updated), $(Get-TimeZone).id))." -Foreground Green

    # Upgrade and/or notify about upgraded packages
	Add-Content -Path "$StatusFile" -Value ""
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
                    Write-Host "  ** Found upgrade for $FeedPackage (v$FeedPackageVersion published $([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $feed.rss.channel.item[$link].updated), $(Get-TimeZone).id)))" -Foreground Magenta
					Add-Content -Path "$StatusFile" -Value "  ** Found upgrade for $FeedPackage (v$FeedPackageVersion published $([System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $feed.rss.channel.item[$link].updated), $(Get-TimeZone).id)))"
    				if ($Notify) {send_notification}
    				if ($AutoUpgrade) {
						if (Get-Process -Name choco -ErrorAction SilentlyContinue) {
							Write-Host "  ** Chocolatey is running elsewhere. Waiting for it to finish..." -Foreground Yellow
                 		    while (Get-Process -Name choco -ErrorAction SilentlyContinue) {Start-Sleep 1}
	                    }
						& choco upgrade $FeedPackage -y
						if ($?) {
							Add-Content -Path "$StatusFile" -Value "  ** choco upgrade of $FeedPackage SUCCESSFUL."
						} else {
							Add-Content -Path "$StatusFile" -Value "  ** choco upgrade of $FeedPackage FAILED."
						}
					}
    			}
    	    }
        }
    }
    if (!($FoundUpgrades)) {
		Write-Host "  ** No packages to upgrade." -Foreground Magenta
		Add-Content -Path "$StatusFile" -Value "  ** No packages to upgrade."
		}
    $WaitTimeRemaining=$WaitTime
	Write-Host "  ** Waiting $WaitTimeRemaining minutes before checking again...`r" -Foreground Cyan -NoNewLine
    while ($WaitTimeRemaining -gt 0) {
		Write-Host "  ** Waiting $WaitTimeRemaining minutes before checking again...   `r" -Foreground Cyan -NoNewLine
	    Sleep 60
	    $WaitTimeRemaining=$WaitTimeRemaining-1
	}
	if (Test-Path "$StatusFile") {Remove-Item "$StatusFile"}
}
