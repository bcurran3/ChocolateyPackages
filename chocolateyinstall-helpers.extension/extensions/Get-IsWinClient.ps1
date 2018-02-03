function Get-IsWinClient{
$IsWinClient=(Get-WmiObject win32_operatingsystem).caption
 if ($IsWinClient -match "Server") {return $false} else {return $true}
}