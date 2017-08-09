$packageName  = 'choco-package-list-backup' 
$script       = "choco-package-list-backup.ps1"

Remove-Item $env:ChocolateyInstall\bin\$script -Force -ErrorAction 'SilentlyContinue'
