function Get-IsWinServerEssentials{
$server=Get-IsWinServer
if ($server -ne $true) {
   return $false
   } else {
     $IsServerEssentials=((Get-WmiObject win32_operatingsystem).caption)
     if ($IsServerEssentials -match "Essentials") {return $true} else {return $false}
    }
}	