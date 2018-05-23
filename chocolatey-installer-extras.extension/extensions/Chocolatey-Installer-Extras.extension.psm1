$scriptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition
 
$publicFunctions = @(
    'Start-PreInstallChecks',
	'Get-PendingRebootStatus',
    'Get-WindowsInstallerStatus',
	'Get-chocoStatus'
)

Get-ChildItem -Path "$scriptRoot\*.ps1" | ForEach-Object { . $_ }
Export-ModuleMember -Function $publicFunctions

Set-Alias Install-ChocolateyPackage Start-PreInstallChecks -Force -Scope Global