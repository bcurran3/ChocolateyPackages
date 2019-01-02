$ErrorActionPreference = 'Stop'
$packageName  = 'vmware-powercli-psmodule'
$shortcutName = 'VMware.PowerCLI.lnk'

Get-InstalledModule -Name "VMware.*" |  Uninstall-Module -AllVersions -Force

Remove-Item "$env:Public\Desktop\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -Force -ErrorAction 'SilentlyContinue'
