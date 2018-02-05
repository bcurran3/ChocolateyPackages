function Get-IsWin10{
$IsWin10=[Environment]::OSVersion.Version.Major
if ($IsWin10 -ge "10" -and $IsWin10 -lt "11") {return $true} else {return $false}
}  