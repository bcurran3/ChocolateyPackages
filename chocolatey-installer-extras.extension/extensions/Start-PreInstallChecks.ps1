function Start-PreInstallChecks {
param([array[]]$packageArgs)

#param($packageArgs)
#param([string]$packageArgs)
#param([array]$packageArgs)
#param([string[]]$packageArgs)
#        [Parameter(ValueFromPipeline = $true)]
#        [System.Diagnostics.Process[]]
#        $packageArgs
#[parameter(Position=0,ValueFromPipeline=$True)]
#[String[]] $packageArgs

$packageArgs

Write-Host "PRE-INSTALLATION STATUS:" -foreground magenta
if (Get-PendingRebootStatus) 
   {
    Write-Host "  ** WARNING: Pending reboot found." -foreground red 
   } else {
     Write-Host "  ** Pending reboot NOT found." -foreground green
	}
Get-WindowsInstallerStatus
Get-chocoStatus
Install-ChocolateyPackageOriginal @packageArgs
}

#close but not there yet