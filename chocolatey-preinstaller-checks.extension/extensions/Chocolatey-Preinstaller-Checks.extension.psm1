$scriptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition
 
$publicFunctions = @(
    'Get-chocoCounts',
	'Get-chocoStatus',
	'Get-PendingRebootStatus',
    'Get-WindowsInstallerStatus',
	'Start-PreinstallChecks',
	'Start-PreuninstallChecks'
)

Get-ChildItem -Path "$scriptRoot\*.ps1" | ForEach-Object { . $_ }
Export-ModuleMember -Function $publicFunctions

Set-Alias Install-ChocolateyInstallPackage Start-PreinstallChecks -Force -Scope Global
Set-Alias Uninstall-ChocolateyPackage Start-PreuninstallChecks -Force -Scope Global