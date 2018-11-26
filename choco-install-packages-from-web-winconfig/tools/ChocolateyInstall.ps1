$ErrorActionPreference = 'Stop'
$packageName = 'choco-install-packages-from-web-winconfig'
$pp          = Get-PackageParameters

# Set Windows to auto-run .nupkg files with cinst.exe
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
New-Item -Path "HKCR:" -Name ".nupkg" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\.nupkg"-Name "(Default)" -Value "nupkg_auto_file"
New-Item -Path "HKCR:" -Name "nupkg_auto_file" –Force | Out-Null
New-Item -Path "HKCR:\nupkg_auto_file" -Name "shell" –Force | Out-Null
New-Item -Path "HKCR:\nupkg_auto_file\shell" -Name "open" –Force | Out-Null
New-Item -Path "HKCR:\nupkg_auto_file\shell\open" -Name "command" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\nupkg_auto_file\shell\open\command" -Name "(Default)" -Value """$env:ChocolateyInstall\bin\cinst.exe"" %1 %2 %3 %4 %5" | Out-Null

# Set cinst.exe compatibility to "Run this program as an administrator" for all users
Write-Host "  * "$packageName": Configuring for all users of $env:COMPUTERNAME."  -foreground magenta
New-Item -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion" -Name "AppCompatFlags" -ea SilentlyContinue | Out-Null
New-Item -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" -Name "Layers" -ea SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -Name "$env:ChocolateyInstall\bin\cinst.exe" -Value "RUNASADMIN" | Out-Null
