﻿$ErrorActionPreference = 'Stop'
$packageName  = 'choco-upgrade-all-at'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$pp           = Get-PackageParameters
$scriptDir    = "$(Get-ToolsLocation)\BCURRAN3"
$script       = 'choco-upgrade-all.ps1'
$ScriptConfig = 'choco-upgrade-all.config'

# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$ENV:ChocolateyToolsLocation\BCURRAN3")) { New-Item -Path "$ENV:ChocolateyToolsLocation" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force -ErrorAction SilentlyContinue
Move-Item "$toolsDir\choco-install.ps1" "$scriptDir" -Force -ErrorAction SilentlyContinue
if (!(Test-Path "$scriptDir\$ScriptConfig")) { Move-Item "$toolsDir\$ScriptConfig" "$scriptDir" -Force }

# Create "shim"
Install-ChocolateyPowershellCommand -PackageName 'choco-upgrade-all' -PSFileFullPath "$scriptDir\$script"
Install-ChocolateyPowershellCommand -PackageName 'choco-install' -PSFileFullPath "$scriptDir\choco-install.ps1"

# Cleanup
Remove-Item "$toolsDir\choco-upgrade-all.*" -Force -ErrorAction SilentlyContinue | Out-Null
if ($ENV:Path -NotMatch "BCURRAN3"){ Install-ChocolateyPath "$scriptDir" "Machine" ; refreshenv }

# delete old task name < v0.0.4 if it exists
$ErrorActionPreference = 'Continue'
$GotTask = (&schtasks /QUERY /TN "choco upgrade all at") 2> $null
$ErrorActionPreference = 'Stop'
if ($null -ne $GotTask){
     &SchTasks /DELETE /TN "choco upgrade all at" /F 
   }

$ErrorActionPreference = 'Continue'
$GotTask      = (&schtasks /QUERY /TN "choco-upgrade-all-at") 2> $null
$ErrorActionPreference = 'Stop'

# Change task to run new batch file and keep other existing settings (v0.0.0.5 to v0.0.0.6 upgrade)
if ($null -ne $GotTask){
     &SchTasks /CHANGE /TN "choco-upgrade-all-at" /TR "%ChocolateyInstall%\bin\choco-upgrade-all.bat"
   }

# check if choco-ugrade-all-at task already exists and exit if so
if ($null -ne $GotTask){
     Write-Host "  ** Existing choco-upgrade-all-at scheduled task found. Keeping existing scheduled task.`n     If you want to change the task runtime or abort time, uninstall and reinstall the package." -Foreground Magenta 
     exit
   }

# exit if a scheduled task is not wanted
if ($pp["NOTASK"] -eq 'true' -or $pp["NOSCHEDULE"] -eq 'true'){
       Write-Host "  ** NOTASK or NOSCHEDULE specified, not installing scheduled task." -Foreground Magenta
	   exit
   }

# begin setup of scheduled task if one doesn't exist
Write-Host "" 
Write-Host "CHOCO-UPGRADE-ALL-AT Summary:" -Foreground Magenta

if ($null -eq $pp["USER"] -or $pp["USER"] -eq ''){
       Write-Host "  ** USER NOT specified, defaulting to SYSTEM." -Foreground Magenta
	   $RunAsUser = 'SYSTEM'
     } else {
	   if ($pp["USER"] -eq 'CURRENTUSER'){
	       $RunAsUser = $env:USERNAME
	       } else {
	         $RunAsUser = $pp["USER"]
	         Write-Host " ** USER specified as $RunAsUser." -Foreground Magenta
            } 
	}

if ($null -eq $pp["TIME"] -or $pp["TIME"] -eq ''){
	   $RunTime = "02:00"
       Write-Host "  ** TIME NOT specified, defaulting to $RunTime." -Foreground Magenta
     } else {
	   $RunTime = $pp["TIME"]
	   Write-Host "  ** TIME specified as $RunTime." -Foreground Magenta
      } 

if ($null -eq $pp["ABORTTIME"] -or $pp["ABORTTIME"] -eq ''){
      $AbortTime = (Get-Date $RunTime).AddHours(2).ToString("HH:mm")
      Write-Host "  ** ABORTTIME NOT specified, defaulting to $AbortTime." -Foreground Magenta
    } else {
	  $AbortTime = $pp["ABORTTIME"]
	  Write-Host "  ** ABORTTIME specified as $AbortTime." -Foreground Magenta
    }
	  
if (($null -eq $pp["DAILY"] -or $pp["DAILY"] -eq '') -and ($null -eq $pp["WEEKLY"] -or $pp["WEEKLY"] -eq '')){
      Write-Host "  ** DAILY or WEEKLY NOT specified, defaulting to DAILY." -Foreground Magenta
      SchTasks /CREATE /SC DAILY /RU $RunAsUser /RL HIGHEST /TN choco-upgrade-all-at /TR "%ChocolateyInstall%\bin\choco-upgrade-all.bat" /ST $RunTime /F
	  SchTasks /QUERY /TN "choco-upgrade-all-at"
	  SchTasks /CREATE /SC DAILY /RU $RunAsUser /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
      SchTasks /QUERY /TN "choco-upgrade-all-at-abort"
	  Start-Sleep -s 10
 	  exit
    }
		  
if ($null -eq $pp["DAILY"] -or $pp["DAILY"] -eq ''){
       Write-Host "  ** DAILY NOT specified." -Foreground Magenta
     } else {
	   Write-Host "  ** DAILY specified." -Foreground Magenta
	   SchTasks /CREATE /SC DAILY /RU $RunAsUser /RL HIGHEST /TN choco-upgrade-all-at /TR "%ChocolateyInstall%\bin\choco-upgrade-all.bat" /ST $RunTime /F
	   SchTasks /QUERY /TN "choco-upgrade-all-at"
	   SchTasks /CREATE /SC DAILY /RU $RunAsUser /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
       SchTasks /QUERY /TN "choco-upgrade-all-at-abort"
	   Start-Sleep -s 10
	   exit
	   }  
		  
if ($null -eq $pp["WEEKLY"] -or $pp["WEEKLY"] -eq ''){
       Write-Host "  ** WEEKLY NOT specified." -Foreground Magenta
     } else {
	   Write-Host "  ** WEEKLY specified." -Foreground Magenta
       if ($null -eq $pp["DAY"] -or $pp["DAY"] -eq ''){
            Write-Host " * DAY NOT specified, defaulting to SUNDAY." -Foreground Magenta
            SchTasks /CREATE /SC WEEKLY /D SUN /RU $RunAsUser /RL HIGHEST /TN choco-upgrade-all-at /TR "%ChocolateyInstall%\bin\choco-upgrade-all.bat" /ST $RunTime /F
		    SchTasks /QUERY /TN "choco-upgrade-all-at"
			SchTasks /CREATE /SC WEEKLY /D SUN /RU $RunAsUser /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
            SchTasks /QUERY /TN "choco-upgrade-all-at-abort"
          } else {
		    $RunDay = $pp["DAY"]
            Write-Host "  ** DAY specified as $RunDay." -Foreground Magenta
		    SchTasks /CREATE /SC WEEKLY /D $pp["DAY"] /RU $RunAsUser /RL HIGHEST /TN choco-upgrade-all-at /TR "%ChocolateyInstall%\bin\choco-upgrade-all.bat" /ST $RunTime /F
		    SchTasks /QUERY /TN "choco-upgrade-all-at"
            SchTasks /CREATE /SC WEEKLY /D $pp["DAY"] /RU $RunAsUser /RL HIGHEST /TN choco-upgrade-all-at-abort /TR "taskkill /im choco.exe /f /t" /ST $AbortTime /F
            SchTasks /QUERY /TN "choco-upgrade-all-at-abort"
	      }
		}
Start-Sleep -s 10
