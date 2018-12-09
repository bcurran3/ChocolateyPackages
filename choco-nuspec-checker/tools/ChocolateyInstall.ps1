$packageName  = 'choco-nuspec-checker' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$script       = "CNC.ps1"

Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force 

$CheckExecutionPolicy=Get-ExecutionPolicy
Write-Host "  ** $packageName - FYI: Your PowerShell Execution Policy is curently set to $CheckExecutionPolicy" -ForeGround Yellow
