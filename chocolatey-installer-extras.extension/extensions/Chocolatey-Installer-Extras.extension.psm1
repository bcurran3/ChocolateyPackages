$scriptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition
$ExtensionDir = "$env:ChocolateyInstall\extensions\chocolatey-installer-extras"

#if (Test-Path $ExtensionDir\Install-ChocolateyPackageOriginal.ps1)
     #{
#      Remove-Item $ExtensionDir\Install-ChocolateyPackageOriginal.ps1 -Force -ErrorAction SilentlyContinue
	 #} else {
#       Copy-Item $env:ChocolateyInstall\helpers\functions\Install-ChocolateyPackageOriginal.ps1 -Destination $ExtensionDir -force	 
#	 }

#function Update-Install-ChocolateyPackage{
# change function name
#}
 
$publicFunctions = @(
    'Start-PreInstallChecks',
	'Get-PendingRebootStatus',
    'Get-WindowsInstallerStatus',
	'Get-chocoStatus',
	'Install-ChocolateyPackageOriginal'
)

Get-ChildItem -Path "$scriptRoot\*.ps1" | ForEach-Object { . $_ }
Export-ModuleMember -Function $publicFunctions

Set-Alias Install-ChocolateyPackage Start-PreInstallChecks -Force -Scope Global