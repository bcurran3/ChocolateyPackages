function Get-IsSSD{
$IsSSD=(Get-WmiObject Win32_DiskDrive).Model
if ($IsSSD -match "SSD") {return $true} else {return $false}
}