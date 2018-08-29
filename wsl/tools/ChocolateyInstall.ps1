$ErrorActionPreference = 'Stop'
$packageName = 'wsl'
$pp          = Get-PackageParameters
$ubuntu1804Url= 'https://aka.ms/wsl-ubuntu-1804'
$ubuntu1604Url='https://aka.ms/wsl-ubuntu-1604'
$opensuseUrl='https://aka.ms/wsl-opensuse-42'
$SLESUrl='https://aka.ms/wsl-sles-12'

if (Get-IsWin10){
    if (Get-WinVerBuild -egt 1607){
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
		if (Get-PendingReboot) {Write-Warning "A reboot is required to use WSL."
	} else {
	  Write-Warning "Microsoft Windows Subsystem for Linux is only supported on Windows 10 builds 1607 and later."
	  throw
	 }
}

if (Get-IsWinServer2016){
    if (Get-WinVerBuild -egt 1709){
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
        if (Get-PendingReboot) {Write-Warning "A reboot is required to use WSL."		
	} else {
	  Write-Warning "Microsoft Windows Subsystem for Linux is only supported on Windows Server 2016 builds 1709 and later."
	  throw
	 }
}

# Need to add Server 2019 compatibility in the future
