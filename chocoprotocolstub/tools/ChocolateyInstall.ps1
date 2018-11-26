$ErrorActionPreference = 'Stop'
$packageName = 'chocoprotocolstub'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Move the chocoProtocolStub.exe to where it can be easily accessed in the path
Move-Item "$toolsDir\chocoProtocolStub.exe" $env:ChocolateyInstall\bin -Force

# Set Windows to auto-run .nupkg files with cinst.exe
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
New-Item -Path "HKCR:" -Name "choco" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\choco" -Name "(Default)" -Value '"URL:choco Protocol"' | Out-Null
Set-ItemProperty -Path "HKCR:\choco" -Name "URL Protocol" -Value '""' | Out-Null
New-Item -Path "HKCR:\choco" -Name "shell" –Force | Out-Null
New-Item -Path "HKCR:\choco\shell" -Name "open" –Force | Out-Null
New-Item -Path "HKCR:\choco\shell\open" -Name "command" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\choco\shell\open\command" -Name "(Default)" -Value """$env:ChocolateyInstall\bin\chocoProtocolStub.exe"" ""%1""" | Out-Null

# Set cinst.exe compatibility to "Run this program as an administrator" for all users
Write-Host "  * "$packageName": Configuring for all users of $env:COMPUTERNAME."  -foreground magenta
New-Item -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion" -Name "AppCompatFlags" -ea SilentlyContinue | Out-Null
New-Item -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" -Name "Layers" -ea SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -Name "$env:ChocolateyInstall\bin\cinst.exe" -Value "RUNASADMIN" | Out-Null
