function Get-WinName{
$WinName=(Get-WmiObject win32_operatingsystem).caption
return $WinName
}