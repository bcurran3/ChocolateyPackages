function Get-IsWinHome{
$IsWinHome=(Get-WmiObject win32_operatingsystem).caption
 if ($IsWinHome -match "Home") {return $true} else {return $false}
}