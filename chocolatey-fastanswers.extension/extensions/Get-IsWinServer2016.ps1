function Get-IsWinServer2016{
$server=Get-IsWinServer
if ($server -eq $false) {return $false}
$major=[Environment]::OSVersion.Version.Major
$minor=[Environment]::OSVersion.Version.Minor
if ($major -eq "10" -and $minor -eq "0") {return $true} else {return $false}
}
