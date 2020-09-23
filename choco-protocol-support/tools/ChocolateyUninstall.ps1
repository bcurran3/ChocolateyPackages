$ErrorActionPreference = 'Stop'
$packageName = 'choco-protocol-support'

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
Remove-Item -Path "HKCR:choco" -Recurse –Force | Out-Null
