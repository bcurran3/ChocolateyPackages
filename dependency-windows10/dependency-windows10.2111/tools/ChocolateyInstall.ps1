$ErrorActionPreference = 'Stop'
$packageName = 'dependency-windows10'

$IsWin10=[Environment]::OSVersion.Version.Major
if ($IsWin10 -ne "10") 
   {
    Write-Warning "This package requires Windows 10."
	throw
   }

$IsCorrectBuild=[Environment]::OSVersion.Version.Build
if ($IsCorrectBuild -lt "19044")
   {
    Write-Warning "** This package requires at least Windows 10 version 21H2/OS build 19044.x."
	Write-Host "FYI:     ** If this is a new install, use the --version option and your corresponding Windows release." -Foreground Magenta
	Write-Host "FYI:     ** See https://chocolatey.org/packages/dependency-windows10#versionhistory" -Foreground Magenta
	Write-Host "FYI:     ** You can use Windows 10 Update Assistant to update to the latest version of Windows 10." -Foreground Cyan
	Write-Host "FYI:     ** See https://chocolatey.org/packages/windows-10-update-assistant" -Foreground Cyan
	throw
   }
