# chocolatey-font-helpers.extension v0.0.1-pre (07-23-2018) by Bill Curran - public domain
# https://blogs.technet.microsoft.com/deploymentguys/2010/12/04/adding-and-removing-fonts-with-windows-powershell/

$scriptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition

$publicFunctions = @(
    'Install-ChocolateyFont',
    'Uninstall-ChocolateyFont'
)
 
Get-ChildItem -Path "$scriptRoot\*.ps1" | ForEach-Object { . $_ }
Export-ModuleMember -Function $publicFunctions