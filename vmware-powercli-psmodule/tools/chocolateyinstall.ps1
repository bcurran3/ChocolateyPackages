﻿$ErrorActionPreference = 'Stop'
$packageName = 'vmware-powercli-psmodule'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'VMware.PowerCLI.lnk'
$exe          = "$ENV:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

$PSversion = $PSVersionTable.PSVersion.Major
if ($PSversion -lt "5")
   {
    Write-Warning "  ** PowerShell < v5 detected."
	Write-Warning "  ** $packageName installs via the PowerShell Gallery and thus requires PowerShell v5+."
	Write-Warning "  ** If PowerShell v5 was installed as a dependency, you need to reboot and reinstall this package."
	throw
   }

if (Get-Module -ListAvailable -Name VMware.PowerCLI -ErrorAction SilentlyContinue){
# Will fail if packageVersion is a revised version not matching module version, i.e. x.x.x.0020180101
     Update-Module "VMware.PowerCLI" -RequiredVersion "$ENV:packageVersion" -Force
   } else {   
     Get-PackageProvider -Name NuGet -Force
     Install-Module -Name VMware.PowerCLI -Scope AllUsers -RequiredVersion $ENV:packageVersion -AllowClobber -Force
   }

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -Arguments '-noe -c "Import-Module VMware.PowerCLI"' -WorkingDirectory "$ENV:SystemDrive\" -Description 'VMware.PowerCLI' -IconLocation "$toolsDir\powercli.ico" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -Arguments '-noe -c "Import-Module VMware.PowerCLI"' -WorkingDirectory "$ENV:SystemDrive\" -Description 'VMware.PowerCLI' -IconLocation "$toolsDir\powercli.ico" -RunAsAdmin
