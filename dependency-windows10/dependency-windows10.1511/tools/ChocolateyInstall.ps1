$packageName = 'dependency-windows10'

$IsWin10=[Environment]::OSVersion.Version.Major
if ($IsWin10 -ne "10") 
   {
    Write-Warning "This package requires Windows 10."
	throw
   }

$IsCorrectBuild=[Environment]::OSVersion.Version.Build
if ($IsCorrectBuild -lt "10586")
   {
    Write-Warning "This package requires at least Windows 10 version 1511/OS build 10586.x."
	throw
   }
