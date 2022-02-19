$ErrorActionPreference = 'Stop'
$packageName = 'dependency-windows11'

$IsWin10=[Environment]::OSVersion.Version.Major
if ($IsWin10 -ne "10") 
   {
    Write-Warning "This package requires Windows 11."
	throw
   }

$IsCorrectBuild=[Environment]::OSVersion.Version.Build
if ($IsCorrectBuild -lt "22000")
   {
    Write-Warning "** This package requires at least Windows 11 version 21H2/OS build 22000.x."
	Write-Host "FYI:     ** If this is a new install, use the --version option and your corresponding Windows release." -Foreground Magenta
	Write-Host "FYI:     ** See https://chocolatey.org/packages/dependency-windows11#versionhistory" -Foreground Magenta
	Write-Host "FYI:     ** You can use Windows 11 Update Assistant to update to the latest version of Windows 11." -Foreground Cyan
	Write-Host "FYI:     ** See https://community.chocolatey.org/packages/windows-11-installation-assistant" -Foreground Cyan
	throw
   }
