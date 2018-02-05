function Get-IsWin7{
$major=[Environment]::OSVersion.Version.Major
$minor=[Environment]::OSVersion.Version.Minor
if ($major -eq "6" -and $minor -lt "1") {return $true} else {return $false}
}