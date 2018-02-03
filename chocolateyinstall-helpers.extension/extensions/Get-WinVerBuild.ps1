function Get-WinVerBuild{
$WinVerBuild=[Environment]::OSVersion.Version.Build
return $WinVerBuild
}