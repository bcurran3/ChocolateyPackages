$ErrorActionPreference = 'Stop'
$packageName = 'windows-sandbox'
$OSBuild = Get-WinVerBuild
$OSFound = (Get-WinName) + " " + (Get-WinVerMajor) + "." + (Get-WinVerMinor) + "." + (Get-WinVerBuild)
Write-Host "  ** OS Found: $OSFound" -Foreground Magenta

if ((Get-IsWinPro) -or (Get-IsWinEnt)) {
    Enable-WindowsOptionalFeature -Online -FeatureName  Containers-DisposableClientVM -NoRestart |Out-Null
    if (Get-PendingReboot) {
	   Write-Warning "A reboot is required to use Windows Sandbox."
	   }
	} else {
	  Write-Host "  ** Windows Sandbox requires Windows 10 Pro or Windows 10 Enterprise."
	  throw
	  }
