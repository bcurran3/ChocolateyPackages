function Get-IsWinEnt{
$IsWinEnt=(Get-WmiObject win32_operatingsystem).caption
 if ($IsWinEnt -match "Enterprise") {return $true} else {return $false}
}