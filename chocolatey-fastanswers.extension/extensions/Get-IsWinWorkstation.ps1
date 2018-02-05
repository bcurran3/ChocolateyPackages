function Get-IsWinWorkstation{
$IsWinWorkstation=(Get-WmiObject win32_operatingsystem).caption
 if ($IsWorkstation -match "Server") {return $false} else {return $true}
}