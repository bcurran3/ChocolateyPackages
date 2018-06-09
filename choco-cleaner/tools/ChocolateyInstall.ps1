$packageName      = 'choco-cleaner'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$script           = 'choco-cleaner.ps1'
$xml              = 'choco-cleaner.xml'
$shortcutName     = 'Choco Cleaner.lnk'
$altshortcutName  = 'Chocolatey Cleaner.lnk'
$GotTask          = (&schtasks /query /tn choco-cleaner) 2> $null

Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue

if ($GotTask -ne $null){
   Write-Host
   Write-Host Existing choco-cleaner scheduled task found: -foreground magenta 
   SchTasks /query /tn "choco-cleaner"
   Write-Host Keeping existing scheduled task and upgrading script files. -foreground magenta
   }


if (Test-Path $env:ChocolateyInstall\bin\$xml){
      Write-Host "Existing $xml file found, your preferences have been saved." -foreground magenta
      Remove-Item $toolsDir\$xml -Force -ErrorAction SilentlyContinue
    } else {
	  Move-Item "$toolsDir\$xml" $env:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue
      $WhoAmI=whoami
      $Acl = Get-Acl "$env:ChocolateyInstall\bin\$xml"
      $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"FullControl","Allow")
      $Acl.SetAccessRule($Ar)
      Set-Acl "$env:ChocolateyInstall\bin\$xml" $Acl	  
	}
	
If (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $env:ChocolateyInstall\bin\$script" -IconLocation $env:ChocolateyInstall\choco.exe -WorkingDirectory $env:ChocolateyInstall\bin\ -RunAsAdmin
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$altshortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $env:ChocolateyInstall\bin\$script" -IconLocation $env:ChocolateyInstall\choco.exe -WorkingDirectory $env:ChocolateyInstall\bin\ -RunAsAdmin
	}	
if ($GotTask -ne $null){ exit }
SchTasks /Create /SC WEEKLY /D SUN /RU SYSTEM /RL HIGHEST /TN "choco-cleaner" /TR "cmd /c powershell -NoProfile -ExecutionPolicy Bypass -Command %ChocolateyInstall%\bin\choco-cleaner.ps1" /ST 23:00 /F
SchTasks /query /tn "choco-cleaner"
Write-Host "Now configured to run choco-cleaner at 11:00 PM every SUNDAY." -foreground green
Write-Host "TO MANUALLY RUN CHOCO-CLEANER:" -foreground magenta
Write-Host "COMMAND PROMPT: $env:ChocolateyInstall\lib\choco-cleaner\tools\choco-cleaner-manual.bat" -foreground magenta
Write-Host "POWERSHELL: $env:ChocolateyInstall\bin\choco-cleaner.ps1" -foreground magenta
Write-Host "WINDOWS START MENU: click the Chocolatey Cleaner icon. If you have choco-shortcuts-winconfig installed you'll find Choco Cleaner with the rest of the Chocolatey shortcuts." -foreground magenta


