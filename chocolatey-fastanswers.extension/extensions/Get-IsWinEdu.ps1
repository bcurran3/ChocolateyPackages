function Get-IsWinEdu{
$IsWinEdu=(Get-WmiObject win32_operatingsystem).caption
 if ($IsWinEdu -match "Education") {return $true} else {return $false}
}