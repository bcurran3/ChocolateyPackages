# v0.0.2.1
$packageName  = 'choco-shortcuts-winconfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

New-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey" -type directory -ea SilentlyContinue| out-null
New-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support" -type directory -ea silentlycontinue| out-null

# move icon for Choco Cleaner if installed
# https://chocolatey.org/packages/choco-cleaner
$shortcutName     = 'Choco Cleaner.lnk'
$altshortcutName  = 'Chocolatey Cleaner.lnk'
$CheckCC          = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName"
if (Test-Path $CheckCC){
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $env:ChocolateyInstall\bin\choco-cleaner.ps1" -WorkingDirectory $env:ChocolateyInstall\bin\ -RunAsAdmin
	Remove-Item $CheckCC
   }
   
# move icon for Chocolatey Package List Backup if installed
# https://chocolatey.org/packages/choco-package-list-backup
$shortcutName    = 'Package List Backup.lnk'
$altshortcutName = 'Chocolatey Package List Backup.lnk'
$CheckCPLB       = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName"
if (Test-Path $CheckCPLB){
	Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $env:ChocolateyInstall\bin\choco-package-list-backup.ps1" -WorkingDirectory $env:ChocolateyInstall\bin\ -RunAsAdmin
	Remove-Item $CheckCPLB
   }	

# move icon for ChocolateyPowerShell if installed
# https://chocolatey.org/packages/chocolateypowershell
$shortcutName = 'ChocolateyPowerShell.lnk'
$CheckCPS     = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName"
if (Test-Path $CheckCPS){
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-noexit -c $env:ChocolateyInstall\lib\chocolateypowershell\tools\ChocolateyEnvironment.ps1" -WorkingDirectory "$env:SystemDrive\" -RunAsAdmin
	Remove-Item $CheckCPS
   }

$shortcutName = 'Install a Package.lnk'
$ChocoCommand = "/v /c color 0f && set /p package=PACKAGENAME: && choco install !package! && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe -RunAsAdmin

$shortcutName = 'List Installed Packages.lnk'
$ChocoCommand = "/c choco list -l | more && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

$shortcutName = 'List Outdated Packages.lnk'
$ChocoCommand = "/c choco outdated && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

# for licensed editions of Chocolatey
# https://chocolatey.org/pricing#compare
$CheckLicense = "$env:ChocolateyInstall\license\chocolatey.license.xml"
if (Test-Path $CheckLicense){
    $shortcutName = 'Optimize Packages.lnk'
    $ChocoCommand = "/c choco optimize && pause"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe -RunAsAdmin
   }

$shortcutName = 'Search for a Package.lnk'
$ChocoCommand = "/v /c color 0f && set /p package=SEARCHTERM: && choco search !package! --order-by-popularity | more && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

$shortcutName = 'Uninstall a Package.lnk'
$ChocoCommand = "/v /c color 0f && set /p package=PACKAGENAME: && choco uninstall !package! && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe -RunAsAdmin

$shortcutName = 'Upgrade All Packages.lnk'
$ChocoCommand = "/c choco upgrade all && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe -RunAsAdmin

$shortcutName = 'View chocolatey.log.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ChocolateyInstall\logs\chocolatey.log -IconLocation $env:ChocolateyInstall\choco.exe

# More advanced then most users of this package need? Chocolatey-Shortcut-Noise?
# Would be nice under an "Advanced" subfolder in Win7 and Win8, but Win10 groups them all together without subfolders :(
#$shortcutName = 'Show Features.lnk'
#$ChocoCommand = "/c choco features | more && pause"
#Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

# More advanced then most users of this package need? Chocolatey-Shortcut-Noise?
# Would be nice under an "Advanced" subfolder in Win7 and Win8, but Win10 groups them all together without subfolders :(
#$shortcutName = 'Show Sources.lnk'
#$ChocoCommand = "/c choco sources list && pause"
#Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

# I wonder if a pinning choice would be useful? (Again, probably too advanced.)
# I wonder if anyone reads these comments?

$shortcutName = 'WEBSITE - Chocolatey.org.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath https://chocolatey.org/ -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Announcemnents.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath "https://groups.google.com/forum/#!forum/chocolatey-announce" -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Bug Tracker.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://github.com/chocolatey/choco/issues -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Docs.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath https://chocolatey.org/docs -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey FeedBurner.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://feeds.feedburner.com/chocolatey -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Google Groups.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath "https://groups.google.com/forum/#!forum/chocolatey" -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Gitter.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://gitter.im/chocolatey/choco -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Package Requests.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://github.com/chocolatey/chocolatey-package-requests -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Support.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://chocolatey.org/support -IconLocation $env:ChocolateyInstall\choco.exe

$shortcutName = 'WEBSITE - Chocolatey Sites Status.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://status.chocolatey.org -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - BCURRAN3''s Chocolatey Add-ons.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath https://chocolatey.org/packages?q=tag%3Abcurran3 -IconLocation $env:ChocolateyInstall\choco.exe 

Write-Host "  ** You now have a Chocolatey folder full of shortcuts in your Windows Start Menu!" -foreground magenta
