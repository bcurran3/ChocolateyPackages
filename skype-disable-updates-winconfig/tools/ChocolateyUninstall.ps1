$packageName = 'skype-disable-updates-winconfig'

Set-Location -Path $env:SystemDrive\Users
Get-ChildItem * -Include 'Skype-Setup.exe' -Recurse -Force -ea SilentlyContinue | Remove-Item | Out-Null
Write-Warning "Skype will now update via normal methods and Chocolatey."