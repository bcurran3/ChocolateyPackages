function Get-IsWinServerSBS{
$server=Get-IsWinServer
if ($server -ne $true) {
   return $false
   } else {
     $IsServerSBS=((Get-WmiObject win32_operatingsystem).caption)
     if ($IsServerSBS -match "Small") {return $true} else {return $false}
    }
}	