# chocolatey-os-dependency.extension v0.0.1 (04-26-2022) by Bill Curran AKA BCURRAN3 - public domain

$scriptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition
 
$publicFunctions = @(
    'Confirm-Win11',
	'Confirm-Win10'
	'Confirm-Win81',
	'Confirm-Win8',
	'Confirm-Win7'
)
 
Get-ChildItem -Path "$scriptRoot\*.ps1" | ForEach-Object { . $_ }
Export-ModuleMember -Function $publicFunctions