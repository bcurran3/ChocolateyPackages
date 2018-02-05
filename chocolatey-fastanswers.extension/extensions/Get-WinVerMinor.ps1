function Get-WinVerMinor{
$WinVerMinor=[Environment]::OSVersion.Version.Minor
return $WinVerMinor
}
