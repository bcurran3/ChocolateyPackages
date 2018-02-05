function Get-IsWinServerFoundation{
$server=Get-IsWinServer
if ($server -ne $true) {
     return $false
   } else {
     $IsServerFoundation=((Get-WmiObject win32_operatingsystem).caption)
     if ($IsServerFoundation -match "Foundation") {return $true} else {return $false}
    }
}	