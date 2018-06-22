# Runs background job to kill $ProcessName within 5 minutes
function Start-WaitandStop($ProcessName){
$env:ProcessName = $ProcessName

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Start-Job -InitializationScript {Import-Module -Name "$env:ChocolateyInstall\extensions\chocolatey-misc-helpers\Start-WaitandStopActual.ps1"} -ScriptBlock {Start-WaitandStopActual} | Out-Null
Start-Sleep 10
Remove-Item Env:\ProcessName
}
