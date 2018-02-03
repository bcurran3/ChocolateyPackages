function Get-IsWin7{
$IsWin7=[Environment]::OSVersion.Version.Major
if ($IsWin7 -eq "7" -and $IsWin7 -lt "8") {return $true} else {return $false}
}