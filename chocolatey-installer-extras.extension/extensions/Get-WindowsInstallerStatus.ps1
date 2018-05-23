function Get-WindowsInstallerStatus{
$ServiceName = 'msiserver'
$InstallerService = Get-Service -Name $ServiceName

while ($InstallerService.Status -eq 'Running')
   {
    write-host "  ** WARNING: Windows Installer IS running" -foreground red
	Start-Sleep -seconds 30
    $InstallerService.Refresh()
   }
if ($InstallerService.Status -ne 'Running')
    {
     Write-Host "  ** Windows Installer IS NOT running" -foreground green
    }
}

