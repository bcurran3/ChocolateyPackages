function Get-IsWin80{
$IsWin8=[Environment]::OSVersion.Version.Major
$IsWin80=[Environment]::OSVersion.Version.Minor
if ($IsWin8 -eq "8" -and $IsWin80 -eq "0") {return $true} else {return $false}
} 