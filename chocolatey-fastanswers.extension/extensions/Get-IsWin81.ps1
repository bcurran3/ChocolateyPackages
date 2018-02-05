function Get-IsWin81{
$major=[Environment]::OSVersion.Version.Major
$minor=[Environment]::OSVersion.Version.Minor
if ($major -eq "6" -and $minor -eq "2") {return $true} else {return $false}
}  