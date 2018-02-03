function Get-IsWin8{
$IsWin8=[Environment]::OSVersion.Version.Major
if ($IsWin8 -eq "8" -and $IsWin8 -lt "9") {return $true} else {return $false}
}