function Get-IsWinPro{
$IsWinPro=(Get-WmiObject win32_operatingsystem).caption
 if ($IsWinPro -match "Pro") {return $true} else {return $false}
}