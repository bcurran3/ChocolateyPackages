$packageName     = 'choco-nuspec-checker' 
$script          = 'CNC.ps1'

Remove-Item "$env:ChocolateyInstall\bin\$script" -Force | Out-Null
