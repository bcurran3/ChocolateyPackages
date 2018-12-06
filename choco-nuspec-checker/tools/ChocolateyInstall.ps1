$packageName  = 'choco-nuspec-checker' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$script       = "CNC.ps1"

Move-Item "$toolsDir\$script" $env:ChocolateyInstall\bin -Force 
