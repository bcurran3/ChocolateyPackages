function Get-WinVerMajor{
$WinVerMajor=[Environment]::OSVersion.Version.Major
return $WinVerMajor
}