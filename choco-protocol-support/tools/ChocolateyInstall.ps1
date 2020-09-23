$ErrorActionPreference = 'Stop'
$packageName = 'choco-protocol-support'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Setup choco:// Protocol in the registry and assign it to run choco-protocol-support.cmd which in turn runs cinst.exe with help from Sudo
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
New-Item -Path "HKCR:" -Name "choco" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\choco" -Name "(Default)" -Value '"URL:choco Protocol"' | Out-Null
Set-ItemProperty -Path "HKCR:\choco" -Name "URL Protocol" -Value '""' | Out-Null
New-Item -Path "HKCR:\choco" -Name "shell" –Force | Out-Null
New-Item -Path "HKCR:\choco\shell" -Name "open" –Force | Out-Null
New-Item -Path "HKCR:\choco\shell\open" -Name "command" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\choco\shell\open\command" -Name "(Default)" -Value  """$env:ChocolateyInstall\lib\choco-protocol-support\tools\choco-protocol-support.cmd"" ""%1""" | Out-Null
