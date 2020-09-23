# https://answers.microsoft.com/en-us/skype/forum/skype_windesk-skype_startms-skype_installms/how-to-turn-off-skype-automatic-updates-on-pc/cf980eed-d9be-422c-bf0f-3a3871325b26
$packageName = 'skype-disable-updates-winconfig'

Set-Location -Path $env:SystemDrive\Users
Get-ChildItem * -Include 'Skype-Setup.exe' -Recurse -Force -ea SilentlyContinue | Remove-Item | Out-Null
Get-ChildItem * -Include 'Skype for Desktop' -Recurse -Force -ea SilentlyContinue | ForEach {New-Item "$_\Skype-Setup.exe" -ItemType directory} | Out-Null
Write-Warning "Skype will now only be updated by Chocolatey."
