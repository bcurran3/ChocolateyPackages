function Get-IsVMware{
$IsVMware=(Get-WmiObject Win32_ComputerSystem).Manufacturer
if ($IsVMware -match "VMware") {return $true} else {return $false}
} 