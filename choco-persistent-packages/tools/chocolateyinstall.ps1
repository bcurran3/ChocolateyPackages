$ErrorActionPreference = 'Stop'
$packageName = 'choco-persistent-packages'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$pp          = Get-PackageParameters
$TaskCommand = 'cinst $env:ChocolateyInstall\config\persistentpackages.config -y'
$GotTask     = (get-scheduledtask -TaskName "choco-persistent-packages" -ErrorAction SilentlyContinue)
$CheckConfig = "$env:ChocolateyInstall\config\persistentpackages.config"

If (Test-Path $CheckConfig){
    Remove-Item "$toolsDir\persistentpackages.config"
    }Else{
     Move-Item "$toolsDir\persistentpackages.config" "$env:ChocolateyInstall\config" -Force -ErrorAction 'SilentlyContinue'
	 $WhoAmI=whoami
     $Acl = Get-Acl "$env:ChocolateyInstall\config\persistentpackages.config"
     $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"FullControl","Allow")
     $Acl.SetAccessRule($Ar)
     Set-Acl "$env:ChocolateyInstall\config\persistentpackages.config" $Acl
    }

if ($GotTask -ne $null){
    Write-Host
    Write-Host Existing "'choco-persistent-packages'" scheduled task found. Keeping existing scheduled task. -foreground magenta 
    Write-Host Upgrading choco-persistent-packages Chocolatey package files only. -foreground magenta 
    Write-Host If you wish to change the scheduled time, uninstall and re-install the package. -foreground magenta
    exit
   }

if ($pp["Time"] -eq $null -or $pp["Time"] -eq ''){
     $RunTime = "00:00"
     Write-Host
     Write-Host No time specified, defaulting to MIDNIGHT. -foreground magenta 
    } else {
      $RunTime = $pp["Time"]
	 }

SchTasks /Create /SC DAILY /RU SYSTEM /RL HIGHEST /TN "choco-persistent-packages" /TR $TaskCommand /ST $RunTime /F
Write-Host Now configured to run choco-persistent-packages at $RunTime every day. -foreground magenta 

# Reference for possible future use:
# https://technet.microsoft.com/en-us/library/jj649816(v=wps.630).aspx

