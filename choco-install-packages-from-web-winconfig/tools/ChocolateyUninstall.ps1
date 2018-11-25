$ErrorActionPreference = 'Stop'
$packageName = 'choco-install-packages-from-web-winconfig'
$pp          = Get-PackageParameters

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
Remove-Item -Path "HKCR:nupkg_auto_file" -Recurse –Force 
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers\" -Name "$env:ChocolateyInstall\bin\cinst.exe\bin\cinst.exe" -ea SilentlyContinue
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers\" -Name "$env:ChocolateyInstall\bin\cinst.exe\bin\cinst.exe" -ea SilentlyContinue
