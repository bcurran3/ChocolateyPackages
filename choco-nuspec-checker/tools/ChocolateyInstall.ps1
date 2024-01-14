$ErrorActionPreference = 'Stop'
$packageName = 'choco-nuspec-checker'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$scriptDir   = "$(Get-ToolsLocation)\BCURRAN3"
$script      = 'CNC.ps1'

# Setup
# New storage location moving forward for all my Chocolatey scripts
if (!(Test-Path "$(Get-ToolsLocation)\BCURRAN3")) { New-Item -Path "$(Get-ToolsLocation)" -Name "BCURRAN3" -ItemType "Directory" | Out-Null }

# Migration
# Move files before v2019.08.26 from old to new storage location
if (Test-Path "$ENV:ChocolateyInstall\bin\$script") { Remove-Item "$ENV:ChocolateyInstall\bin\$script" -Force }
if (Test-Path "$ENV:ChocolateyInstall\bin\CNCHeader.txt") { Move-Item "$ENV:ChocolateyInstall\bin\CNCHeader.txt" "$scriptDir" -Force }
if (Test-Path "$ENV:ChocolateyInstall\bin\CNCFooter.txt") { Move-Item "$ENV:ChocolateyInstall\bin\CNCFooter.txt" "$scriptDir" -Force }
if (Test-Path "$scriptDir\CNC.cmd") { Remove-Item "$scriptDir\CNC.cmd" -Force | Out-Null } # in v2019.08.26 only

# Install
# Move new files and support files (if applicable)
Move-Item "$toolsDir\$script" "$scriptDir" -Force
if (!(Test-Path "$scriptDir\CNC.config")) { Move-Item "$toolsDir\CNC.config" "$scriptDir" -Force }
Install-ChocolateyPowershellCommand -PackageName 'CNC' -PSFileFullPath "$scriptDir\$script"
# Below files not used after migrating to .config file
#if (!(Test-Path "$scriptDir\CNCHeader.txt")) { Move-Item "$toolsDir\CNCHeader.txt" "$scriptDir" -Force }
#if (!(Test-Path "$scriptDir\CNCFooter.txt")) { Move-Item "$toolsDir\CNCFooter.txt" "$scriptDir" -Force }
#if (!(Test-Path "$scriptDir\CNCPackageNotes.txt")) { Move-Item "$toolsDir\CNCPackageNotes.txt" "$scriptDir" -Force }

# Cleanup
Remove-Item "$toolsDir\CNC*.*" -Force -ErrorAction SilentlyContinue | Out-Null
