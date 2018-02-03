function Get-IsWin81{
$IsWin8=[Environment]::OSVersion.Version.Major
$IsWin81=[Environment]::OSVersion.Version.Minor
if ($IsWin8 -eq "8" -and $IsWin81 -eq "1") {return $true} else {return $false}
}  