$scriptRoot = Split-Path -Path $MyInvocation.MyCommand.Definition
 
$publicFunctions = @(
    'Start-CheckandStop',
	'Start-WaitandStop',
	'Start-WaitandStopActual'
)
 
Get-ChildItem -Path "$scriptRoot\*.ps1" | ForEach-Object { . $_ }
Export-ModuleMember -Function $publicFunctions