$packageName = 'dependency-windows10'

$IsWin10=[Environment]::OSVersion.Version.Major
if ($IsWin10 -ne "10") 
   {
    Write-Warning "This package requires Windows 10."
	throw
   }

$IsCorrectBuild=[Environment]::OSVersion.Version.Build
if ($IsCorrectBuild -lt "15063")
   {
    Write-Warning "This package requires at least Windows 10 version 1703/OS build 15063.x."
	throw
   }
