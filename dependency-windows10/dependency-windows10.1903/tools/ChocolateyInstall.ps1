$ErrorActionPreference = 'Stop'
$packageName = 'dependency-windows10'

$IsWin10=[Environment]::OSVersion.Version.Major
if ($IsWin10 -ne "10") 
   {
    Write-Warning "This package requires Windows 10."
	throw
   }

$IsCorrectBuild=[Environment]::OSVersion.Version.Build
if ($IsCorrectBuild -lt "18362")
   {
    Write-Warning "This package requires at least Windows 10 version 1903/OS build 18362.x."
	throw
   }
