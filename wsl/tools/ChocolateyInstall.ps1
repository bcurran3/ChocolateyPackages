$ErrorActionPreference = 'Stop'
$packageName = 'wsl'

if (Get-IsWin7){
	Write-Warning "Microsoft Windows Subsystem for Linux is not compatible with your version of Windows."
	throw
}

if (Get-IsWin8){
	Write-Warning "Microsoft Windows Subsystem for Linux is not compatible with your version of Windows."
	throw
}

if (Get-IsWin81){
	Write-Warning "Microsoft Windows Subsystem for Linux is not compatible with your version of Windows."
	throw
}

# Not sure if WSL is available in ALL editions of Windows 10
if (Get-IsWin10){
    if (Get-WinVerBuild -egt 1607){
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
		if (Get-PendingReboot) {Write-Warning "A reboot is required to use WSL."
	} else {
	  Write-Warning "Microsoft Windows Subsystem for Linux is only supported on Windows 10 builds 1607 and later."
	  throw
	 }
}

if (Get-IsServer2008){
	Write-Warning "Microsoft Windows Subsystem for Linux is not compatible with your version of Windows Server."
	throw
}

if (Get-IsServer2008R2){
    Write-Warning "Microsoft Windows Subsystem for Linux is not compatible with your version of Windows Server."
	throw
}

if (Get-IsServer2012){
    Write-Warning "Microsoft Windows Subsystem for Linux is not compatible with your version of Windows Server."
	throw
}

if (Get-IsServer2012R2){
    Write-Warning "Microsoft Windows Subsystem for Linux is not compatible with your version of Windows Server."
	throw
}

# Not sure if WSL is available in ALL editions of Windows Server 2016
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
