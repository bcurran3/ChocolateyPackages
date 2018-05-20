$packageName      = 'choco-package-list-backup' 
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$Date             = Get-Date -UFormat %Y-%m-%d
$script           = 'choco-package-list-backup.ps1'
$xml              = 'choco-package-list-backup.xml'
$shortcutName     = 'Chocolatey Package List Backup.lnk'
$oldshortcutName  = 'Choco Package List Backup.lnk'
$altshortcutName  = 'Package List Backup.lnk'

Function Update-Config{
[xml]$UpdatedConfig = Get-Content "$env:ChocolateyInstall\bin\$xml"

$UseiCloudDrive = $UpdatedConfig.Settings.Preferences.UseiCloudDrive
if ($UseiCloudDrive -eq $null)
   {
    Write-Host Adding iCloudDrive support to $xml. -foreground magenta
	$NewStuff=$UpdatedConfig.CreateNode("element", "UseiCloudDrive", $null)
    $NewStuff.InnerText=("true") 
	$UpdatedConfig.Settings.Preferences.AppendChild($NewStuff) | out-null
	$UpdatedFile = "True"
   }
   
if ($UpdatedFile -eq "True")
   {   
    $UpdatedConfig.Save("$env:ChocolateyInstall\bin\$xml")
	Write-Host "Updated $xml" -foreground magenta
   }
}

Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue	

if (Test-Path $env:ChocolateyInstall\bin\$xml){
      Remove-Item $toolsDir\$xml -Force -ErrorAction SilentlyContinue
	  Update-Config
    } else {
	  Move-Item "$toolsDir\$xml" $env:ChocolateyInstall\bin -Force -ErrorAction SilentlyContinue
      $WhoAmI=whoami
      $Acl = Get-Acl "$env:ChocolateyInstall\bin\$xml"
      $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule($WhoAmI,"FullControl","Allow")
      $Acl.SetAccessRule($Ar)
      Set-Acl "$env:ChocolateyInstall\bin\$xml" $Acl
	}
	
If (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
      Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$oldshortcutName" -Force -ErrorAction SilentlyContinue
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey\$altshortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $script" -IconLocation $env:ChocolateyInstall\choco.exe -WorkingDirectory $env:ChocolateyInstall\bin\
    } else {
      Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$env:SystemRoot\system32\WindowsPowerShell\v1.0\powershell.exe" -Arguments "-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command $script" -IconLocation $env:ChocolateyInstall\choco.exe -WorkingDirectory $env:ChocolateyInstall\bin\
	}
	
Write-Host "Running choco-package-list-backup.ps1 to create backup(s)..." -foreground magenta
&powershell -NoProfile -ExecutionPolicy Bypass -Command "$env:ChocolateyInstall\bin\choco-package-list-backup.ps1"
Write-Host "Edit $env:ChocolateyInstall\bin\$xml to customize your backup(s)." -foreground magenta
Write-Host "TO BACKUP YOUR CHOCOLATEY PACKAGE LIST AGAIN:" -foreground magenta
Write-Host "Command Prompt: POWERSHELL CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground magenta
Write-Host "PowerShell    : CHOCO-PACKAGE-LIST-BACKUP.PS1" -foreground magenta
If (Test-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Chocolatey"){
     Write-Host "Windows       : Click Package List Backup in the Start menu under Chocolatey" -foreground magenta
   } else {
     Write-Host "Windows       : Click Chocolatey Package List Backup in the Start menu" -foreground magenta
   }	