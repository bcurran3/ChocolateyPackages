function Get-IsWinServer{
$IsServer=(Get-WmiObject win32_operatingsystem).caption
 if ($IsServer -match "Server") {return $true} else {return $false}
}