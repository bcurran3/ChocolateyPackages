# https://docs.microsoft.com/nl-nl/windows/wsl/install-win10#update-to-wsl-2
# https://devblogs.microsoft.com/commandline/wsl-2-support-is-coming-to-windows-10-versions-1903-and-1909/

$ErrorActionPreference = 'Stop'
$packageName = 'wsl2'
$url            = 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi'
$checksum       = 'F4833159D00077E160C4B87CA4C4066DA0B20BEC69331CD414A6CB62BD88DE70'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'MSI'
  url           = $url
  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/quiet /qn /norestart'
  softwareName  = ''
  checksum      = $checksum
  checksumType  = 'sha256' 
}

# Win10: 2004 / 20H1 + required before 08/20/20 and 1903 + 1909 supported afterwards
if ((Get-IsWinWorkstation) -and (Get-IsWin10)){
$OSBuild=Get-WinVerBuild
$OSFound = (Get-WinName) + " " + (Get-WinVerMajor) + "." + (Get-WinVerMinor) + "." + (Get-WinVerBuild)
Write-Host "  ** OS Found: $OSFound`n" -foreground magenta



here check build 18362 and 18363 for minor build 1049 and set true
change install to if true








    if ($OSBuild -ge 19041){
	    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart | Out-Null
		"$ENV:SystemRoot\system32\wsl --set-default-version 2"
		Install-ChocolateyPackage @packageArgs
		if (Get-PendingReboot) {
		    Write-Warning "A reboot is required to use WSL 2."
			Write-Host 'NOTE: Run wsl --set-version <distribution name> <versionNumber> to convert your old distros.' -ForeGround Magenta
			Write-Host ""
		   }
		return
	   } else {
	     Write-Warning "Microsoft Windows Subsystem for Linux 2 is only supported on Windows 10 2004 (10.0.19041) and later."
	     throw
	    }
}

# WindowsServer2019: Checking for 10.0.18945 (first Windows Insider preview version)
if ((Get-IsWinServer) -and (Get-IsWinServer2019)){
$OSBuild=Get-WinVerBuild
$OSFound = (Get-WinName) + " " + (Get-WinVerMajor) + "." + (Get-WinVerMinor) + "." + (Get-WinVerBuild)
Write-Host "  ** OS Found: $OSFound\n" -foreground magenta
    if ($OSBuild -ge 18945){
	    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart | Out-Null
		"$ENV:SystemRoot\system32\wsl --set-default-version 2"
		Install-ChocolateyPackage @packageArgs
		if (Get-PendingReboot) {
		    Write-Warning "A reboot is required to use WSL 2."
			Write-Host 'NOTE: Run wsl --set-version <distribution name> <versionNumber> to convert your old distros.' -ForeGround Magenta
			Write-Host ""
		   }
		return
	   } else {
	     Write-Warning "Microsoft Windows Subsystem for Linux 2 is only supported on Windows Server 2019 build 10.0.18945 and later."
	     throw
	    }
}
