function Get-IsVM{
$VMware=Get-IsVMware
$VirtualBox=Get-IsVirtualBox
if ($VMware -or $VirtualBox) {return $true} else {return $false}
}