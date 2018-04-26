# https://chocolatey.org/packages/ChocoShortcuts
$packageName  = 'choco-shortcuts-winconfig'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

New-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey" -type directory -ea SilentlyContinue| out-null
New-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support" -type directory -ea silentlycontinue| out-null

$shortcutName = 'Install a Package.lnk'
$ChocoCommand = "/v /c color 0f && set /p package=PACKAGENAME: && choco install !package! && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe -RunAsAdmin

$shortcutName = 'Search for a Package.lnk'
$ChocoCommand = "/v /c color 0f && set /p package=SEARCHTERM: && choco search !package! --order-by-popularity | more && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

$shortcutName = 'Uninstall a Package.lnk'
$ChocoCommand = "/v /c color 0f && set /p package=PACKAGENAME: && choco uninstall !package! && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe -RunAsAdmin

$shortcutName = 'List Installed Packages.lnk'
$ChocoCommand = "/c choco list -l | more && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

$shortcutName = 'List Outdated Packages.lnk'
$ChocoCommand = "/c choco outdated && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

$CheckLicense = "$env:ChocolateyInstall\license\chocolatey.license.xml"
if (Test-Path $CheckLicense){
    $shortcutName = 'Optimize Packages.lnk'
    $ChocoCommand = "/c choco optimize && pause"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe -RunAsAdmin
}

$CheckCPLB = "$env:ChocolateyInstall\bin\choco-package-list-backup.ps1"
if (Test-Path $CheckCPLB){
    $shortcutName = 'Package List Backup.lnk'
	$ChocoCommand = "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $CheckCPLB"
    Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe
	if (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey Package List Backup.lnk") {
	     Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey Package List Backup.lnk"
		}
}

#$shortcutName = 'Show Features.lnk'
#$ChocoCommand = "/c choco features | more && pause"
#Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

#$shortcutName = 'Show Sources.lnk'
#$ChocoCommand = "/c choco sources list && pause"
#Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe

$shortcutName = 'Upgrade All Packages.lnk'
$ChocoCommand = "/c choco upgrade all && pause"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ComSpec -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe -RunAsAdmin

$shortcutName = 'View chocolatey.log.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath $env:ChocolateyInstall\logs\chocolatey.log -IconLocation $env:ChocolateyInstall\choco.exe

$shortcutName = 'WEBSITE - Chocolatey.org.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath https://chocolatey.org/ -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Announcemnents.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath "https://groups.google.com/forum/#!forum/chocolatey-announce" -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Bug Tracker.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://github.com/chocolatey/choco/issues -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Google Groups.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath "https://groups.google.com/forum/#!forum/chocolatey" -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Gitter.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://gitter.im/chocolatey/choco -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Package Requests.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://github.com/chocolatey/chocolatey-package-requests -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - Chocolatey Support.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\Support\$shortcutName"  -targetPath https://chocolatey.org/support -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe 

$shortcutName = 'WEBSITE - BCURRAN3''s Chocolatey Add-ons.lnk'
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName"  -targetPath https://chocolatey.org/packages?q=tag%3Abcurran3 -Arguments $ChocoCommand -IconLocation $env:ChocolateyInstall\choco.exe 
