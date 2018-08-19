$packageName = 'disable-skype-updates-winconfig'

Write-Warning "This only effects the currently logged in user installing the package."
Remove-Item "$env:APPDATA\Microsoft\Skype for Desktop\Skype-Setup.exe" -ea SilentlyContinue | Out-Null
Write-Warning "Skype will now update via normal methods and Chocolatey."