# chocolatey-preinstaller-checks.extension by Bill Curran AKA BCURRAN3 - 2018 public domain
# thanks to http://ilovepowershell.com/2015/09/10/how-to-check-if-a-server-needs-a-reboot/

function Get-PendingRebootStatus{

$RebootStatus=$false
if (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -ErrorAction SilentlyContinue) { $RebootStatus=$true }
if (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -ErrorAction SilentlyContinue) { $RebootStatus=$true }
if (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -ErrorAction SilentlyContinue) { $RebootStatus=$true }
 try { 
   $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
   $status = $util.DetermineIfRebootPending()
   if(($status -ne $null) -and $status.RebootPending){
     RebootStatus=$true
   }
 }catch{}

if ($RebootStatus -eq $true){
     Write-Host "  * WARNING: Pending reboot found." -foreground red 
   } else {
     Write-Host "  * Pending reboot NOT found." -foreground green
   }
}