$ErrorActionPreference = 'Stop'
$packageName    = 'irfanview-languages'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

#TDL - add package parameter to select individual language

if (Test-Path $env:ProgramFiles\IrfanView\Languages) {
	
	Get-Childitem $toolsDir\*.zip | % {Get-ChocolateyUnzip -FileFullPath "$_" -Destination $env:ProgramFiles\IrfanView\Languages}
	Remove-Item $toolsDir\*.zip -EA SilentlyContinue | Out-Null
	} else {
		Write-Warning "Default installation path not found. Aborting..."
		throw
	}
