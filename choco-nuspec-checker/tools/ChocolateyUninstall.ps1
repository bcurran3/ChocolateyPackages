$packageName = 'choco-nuspec-checker' 
$script      = 'CNC.ps1'
$CNCHeader   = 'CNCHeader.txt'
$CNCFooter   = 'CNCFooter.txt'

Remove-Item "$ENV:ChocolateyInstall\bin\$script" -Force | Out-Null
Remove-Item "$ENV:ChocolateyInstall\bin\$CNCHeader" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$ENV:ChocolateyInstall\bin\$CNCFooter" -Force -ErrorAction SilentlyContinue | Out-Null
