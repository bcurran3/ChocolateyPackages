function Get-IsVirtualBox{
$IsVirtualBox=(Get-WmiObject Win32_ComputerSystem).Model
if ($IsVirtualBox -match "VirtualBox") {return $true} else {return $false}
}