$ErrorActionPreference = 'Stop'
$packageName = 'chocoprotocolstub'

Remove-Item "$env:ChocolateyInstall\bin\chocoProtocolStub.exe" -Force
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
Remove-Item -Path "HKCR:choco" -Recurse –Force | Out-Null
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers\" -Name "$env:ChocolateyInstall\bin\cinst.exe" -ea SilentlyContinue | Out-Null
