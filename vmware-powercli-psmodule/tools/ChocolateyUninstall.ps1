$ErrorActionPreference = 'Stop'
$packageName  = 'vmware-powercli-psmodule'
$shortcutName = 'VMware.PowerCLI.lnk'

Uninstall-Module -Name VMware.DeployAutomation -Force
Uninstall-Module -Name VMware.ImageBuilder -Force
Uninstall-Module -Name VMware.PowerCLI -Force
Uninstall-Module -Name VMware.VimAutomation.Cis.Core -Force
Uninstall-Module -Name VMware.VimAutomation.Cloud -Force
Uninstall-Module -Name VMware.VimAutomation.Common -Force
Uninstall-Module -Name VMware.VimAutomation.Core -Force
Uninstall-Module -Name VMware.VimAutomation.HA -Force
Uninstall-Module -Name VMware.VimAutomation.HorizonView -Force
Uninstall-Module -Name VMware.VimAutomation.License -Force
Uninstall-Module -Name VMware.VimAutomation.Nsxt -Force
Uninstall-Module -Name VMware.VimAutomation.PCloud -Force
Uninstall-Module -Name VMware.VimAutomation.Sdk -Force
Uninstall-Module -Name VMware.VimAutomation.Srm -Force
Uninstall-Module -Name VMware.VimAutomation.Storage -Force
Uninstall-Module -Name VMware.VimAutomation.StorageUtility -Force
Uninstall-Module -Name VMware.VimAutomation.Vds -Force
Uninstall-Module -Name VMware.VimAutomation.Vmc -Force
Uninstall-Module -Name VMware.VimAutomation.vROps -Force
Uninstall-Module -Name VMware.VumAutomation -Force

remove-item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
remove-item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
Show-ToastMessage "$packageName uninstalled." "Version $env:packageVersion."

