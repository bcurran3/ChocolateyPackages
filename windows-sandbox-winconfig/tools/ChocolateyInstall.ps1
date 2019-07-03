$ErrorActionPreference = 'Stop'
$packageName = 'windowssandbox'
$OSBuild=Get-WinVerBuild
$OSFound = (Get-WinName) + " " + (Get-WinVerMajor) + "." + (Get-WinVerMinor) + "." + (Get-WinVerBuild)
Write-Host "  ** OS Found: $OSFound" -foreground magenta

# Filter out incompatible Windows OSes
if ((Get-IsWin7) -or (Get-IsWin8) -or (Get-IsWin81)){
	Write-Warning "Windows Sandbox is not compatible with your version of Windows."
	throw
}

# Filter out incompatible Windows Server OSes
if ((Get-IsWinServer2008) -or (Get-IsWinServer2008R2) -or (Get-IsWinServer2012) -or (Get-IsWinServer2012R2)){
	Write-Warning "Windows Sandbox is not compatible with your version of Windows Server."
	throw
}

# Win10: Windows 10 May 2019 Update / 10.0.18362 / 1903 / 19H1 / Redstone 6 + required
if ((Get-IsWinWorkstation) -and (Get-IsWin10)){
    if ($OSBuild -ge 18362){
	    Enable-WindowsOptionalFeature -Online -FeatureName  Containers-DisposableClientVM -NoRestart |Out-Null
		if (Get-PendingReboot) {
		    Write-Warning "A reboot is required to use Windows Sandbox."
		   }
		return
	   } else {
	     Write-Warning "Microsoft Windows Sandbox is only supported on Windows 10 builds 1903 (10.0.18362) and later."
	     throw
	    }
}

# WindowsServer2016: Checking for 1803 / 10.0.17134 + required
if ((Get-IsWinServer) -and (Get-IsWinServer2016)){
    if ($OSBuild -ge 18305){
        Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -NoRestart |Out-Null
		if (Get-PendingReboot) {
		    Write-Warning "A reboot is required to use Windows Sandbox."
		   }
		return
	   } else {
	     Write-Warning "Windows Sandbox is only supported on Windows Server 2016 builds 1803 (10.0.17134) and later."
	     throw
	    }
}

return

# ------------------------------
# prepping below for future use

# WindowsServer2019: Checking for 10.0.17623 (first Windows Insider preview version)
if ((Get-IsWinServer) -and (Get-IsWinServer2019)){ # requires update to chocolatey-fastanswers.extension
    if ($OSBuild -ge 17623){
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart |Out-Null
		if (Get-PendingReboot) {
		    Write-Warning "A reboot is required to use Windows Sandbox."
		   }
		return
	   }
}
