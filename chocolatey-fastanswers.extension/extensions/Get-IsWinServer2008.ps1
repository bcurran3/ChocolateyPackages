function Get-IsWinServer2008{
$server=Get-IsWinServer
if ($server -eq $false) {return $false}
$major=[Environment]::OSVersion.Version.Major
$minor=[Environment]::OSVersion.Version.Minor
if ($major -eq "6" -and $minor -eq "0") {return $true} else {return $false}
}
