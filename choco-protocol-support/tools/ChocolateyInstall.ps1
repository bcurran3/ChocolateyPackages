$ErrorActionPreference = 'Stop'
$packageName = 'choco-protocol-support'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"
$script      = 'choco-protocol-support.ps1'

# Setup
# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$scriptDir")) { New-Item -Path "$(Get-ToolsLocation)" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Install Script
# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force -ErrorAction SilentlyContinue

# Create "shim"
Install-ChocolateyPowershellCommand -PackageName "$packageName" -PSFileFullPath "$scriptDir\$script"

# Cleanup
Remove-Item "$toolsDir\$script" -Force -ErrorAction SilentlyContinue | Out-Null

# Setup choco:// Protocol in the registry and assign it to run choco-protocol-support.cmd which in turn runs choco.exe with help from Sudo
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea SilentlyContinue | Out-Null
New-Item -Path "HKCR:" -Name "choco" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\choco" -Name "(Default)" -Value '"URL:choco Protocol"' | Out-Null
Set-ItemProperty -Path "HKCR:\choco" -Name "URL Protocol" -Value '""' | Out-Null
New-Item -Path "HKCR:\choco" -Name "shell" –Force | Out-Null
New-Item -Path "HKCR:\choco\shell" -Name "open" –Force | Out-Null
New-Item -Path "HKCR:\choco\shell\open" -Name "command" –Force | Out-Null
Set-ItemProperty -Path "HKCR:\choco\shell\open\command" -Name "(Default)" -Value  """$env:ChocolateyInstall\bin\choco-protocol-support.bat"" ""%1""" | Out-Null
