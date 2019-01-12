# chocolatey-misc-helpers.extension v0.0.3.1 (01-12-2019) by Bill Curran - public domain
# Runs a background job to kill $ProcessName within 5 minutes
# You would typically run this before Install-ChocolateyPackage

function Start-WaitandStop($ProcessName){
$ENV:ProcessName = $ProcessName

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Start-Job -InitializationScript {Import-Module -Name "$ENV:ChocolateyInstall\extensions\chocolatey-misc-helpers\Start-WaitandStopActual.ps1"} -ScriptBlock {Start-WaitandStopActual} | Out-Null
Start-Sleep 10
Remove-Item ENV:\ProcessName
}
