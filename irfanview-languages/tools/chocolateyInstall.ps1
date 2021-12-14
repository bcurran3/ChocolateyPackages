$ErrorActionPreference = 'Stop'
$packageName    = 'irfanview-languages'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

#TDL - add package parameter to select individual language

if (Test-Path $env:ProgramFiles\IrfanView\Languages) {
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_arabic.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_chinese.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_czech.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_deutsch.zip" -Destination $env:ProgramFiles\IrfanView
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_estonian.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_finnish.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_french.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_hungarian.zip" -Destination $env:ProgramFiles\IrfanView
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_italian.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_japanese.zip" -Destination $env:ProgramFiles\IrfanView
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_nederlands.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_polski.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_portugues-brasil.zip" -Destination $env:ProgramFiles\IrfanView
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_portuguese.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_russian.zip" -Destination $env:ProgramFiles\IrfanView
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_slovak.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_slovenscina.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_spanish.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Get-ChocolateyUnzip -FileFullPath "$toolsDir\irfanview_lang_ukrainian.zip" -Destination $env:ProgramFiles\IrfanView\Languages
	Remove-Item $toolsDir\*.zip -EA SilentlyContinue | Out-Null
	} else {
		Write-Warning "Default installation path not found. Aborting..."
		throw
	}
