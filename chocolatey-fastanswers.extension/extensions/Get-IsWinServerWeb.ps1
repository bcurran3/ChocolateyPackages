function Get-IsWinServerWeb{
$server=Get-IsWinServer
if ($server -ne $true) {
     return $false
   } else {
     $IsServerWeb=((Get-WmiObject win32_operatingsystem).caption)
     if ($IsServerWeb -match "Web") {return $true} else {return $false}
    }
}	